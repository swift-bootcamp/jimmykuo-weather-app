//
//  ViewController.swift
//  WeatherApp
//
//  Created by jimmy on 2014/8/16.
//  Copyright (c) 2014年 jimmy. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class ViewController: UIViewController, NSURLConnectionDataDelegate {
    
    @IBOutlet var city: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var weather_image: UIImageView!
    @IBOutlet var tempC: UILabel!
    
    @IBOutlet var loading: UIActivityIndicatorView!
    
    var data: NSMutableData = NSMutableData()
    
//    override init(){
//        self.city?.text = "Taipei"
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        loading.stopAnimating()
        city?.text = "Taipei"
//      icon.image = UIImage(named: "rainy.jpg")
        
//        let background = UIImage(named: "rainy.jpg")
//        self.view.backgroundColor = UIColor(patternImage: background)
        
        let singleFingerTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        self.view.addGestureRecognizer(singleFingerTap)
        
        startConnection()
        
        // UIWebView
//        var req: NSURLRequest? = NSURLRequest(URL: NSURL(string: "https://www.google.com.tw/maps/preview?q=taipei&ie=UTF-8&hl=zh-TW&authuser=0"))
//        webview.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.google.com.tw/maps/preview?q=taipei&ie=UTF-8&hl=zh-TW&authuser=0")))

        
//        var url = NSURL(string: "http://www.google.com")
//        var url = NSURL(string: "http://www.yahoo.com.tw")
//        var request = NSURLRequest(URL: url)
//        webview.loadRequest(request)
        
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer){
        startConnection()
    }
    
    func startConnection(){
    
        loading.startAnimating()
        
        var restAPI: String = "http://api.openweathermap.org/data/2.5/weather?q=Taipei"
        var url: NSURL = NSURL(string: restAPI)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(
            request: request, delegate: self, startImmediately: true)
        
//        1. Delegation pattern
//        2. NSURLConnection.sendAsynchronousRequest(<#request: NSURLRequest!#>, queue: NSOperationQueue!, completionHandler: { (<#NSURLResponse!#>, <#NSData!#>, <#NSError!#>) -> Void in
//        <#code#>
//    })
    
        
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
        println(json)
        
        var e: NSError?
        var jsonObj = NSJSONSerialization.JSONObjectWithData(
            self.data,
            options: NSJSONReadingOptions.MutableContainers,
            error: &e) as NSDictionary
        
        let temp: AnyObject? = jsonObj["main"]?["temp"]
        // let tempCC = NSString(format: "%.f", round(temp!.floatValue - 273.15))
        let tempCC = Double(round(temp!.floatValue - 273.15))
        self.tempC.text = "\(tempCC)°C"
        // println(tempCC)
        println("TempC: \(tempCC)")
        
        if let arr:NSArray = jsonObj["weather"]? as? NSArray {
            
            let icon_id = arr[0]["icon"]
            println(icon_id)
            println("http://openweathermap.org/img/w/\(icon_id).png")
            
            //dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                weather_image.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://openweathermap.org/img/w/\(icon_id).png")))
            //})
            
        }
        
        loading.stopAnimating()
        
        // let icon_id = jsonObj["weather"]?[0]?["icon"]
    }
}

