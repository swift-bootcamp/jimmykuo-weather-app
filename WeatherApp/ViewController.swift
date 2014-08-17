//
//  ViewController.swift
//  WeatherApp
//
//  Created by jimmy on 2014/8/16.
//  Copyright (c) 2014年 jimmy. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, NSURLConnectionDataDelegate {
    
    @IBOutlet var city: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var tempC: UILabel!
    
    var data: NSMutableData = NSMutableData()
    
//    override init(){
//        self.city?.text = "Taipei"
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        city?.text = "Taipei"
//      icon.image = UIImage(named: "rainy.jpg")
        
//        let background = UIImage(named: "rainy.jpg")
//        self.view.backgroundColor = UIColor(patternImage: background)
        
        let singleFingerTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        self.view.addGestureRecognizer(singleFingerTap)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer){
        startConnection()
    }
    
    func startConnection(){
        var restAPI: String = "http://api.openweathermap.org/data/2.5/weather?q=Taipei"
        var url: NSURL = NSURL(string: restAPI)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(
            request: request, delegate: self, startImmediately: true)
        
        println("start downloading")
        self.data.setData(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func connection(connection: NSURLConnection!, didReceiveData dataReceived: NSData!) {
        println("downloading")
        self.data.appendData(dataReceived)
    }

    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("download finished")
        var json: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)
//        println(json)
        
        var e: NSError?
        var jsonObj = NSJSONSerialization.JSONObjectWithData(
            self.data,
            options: NSJSONReadingOptions.MutableContainers,
            error: &e) as NSDictionary
        
        let temp: AnyObject? = jsonObj["main"]?["temp"]
        // let tempCC = NSString(format: "%.f", round(temp!.floatValue - 273.15))
        let tempCC = Double(round(temp!.floatValue - 273.15))
        self.tempC.text = "\(tempCC)"
        // println(tempCC)
        println("TempC: \(tempCC)")
    }
}

