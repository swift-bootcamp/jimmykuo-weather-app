//
//  ViewController.swift
//  WeatherApp
//
//  Created by jimmy on 2014/8/16.
//  Copyright (c) 2014年 jimmy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var city: UILabel!
    
//    override init(){
//        self.city?.text = "Taipei"
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.city?.text = "Taipei"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

