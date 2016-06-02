//
//  ViewController.swift
//  WeatherApp
//
//  Created by Guillaume on 02/06/16.
//  Copyright © 2016 Guillaume. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var previsionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func validButton(sender: AnyObject) {
        
        let city = textField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-")
        let url = NSURL(string: "http://www.weather-forecast.com/locations/\(city)/forecasts/latest")
        
        var isValid = false
        if let validUrl = url {
            let request = NSURLSession.sharedSession().dataTaskWithURL(validUrl) { (data, response, error) in
                
                if let donnees = data {
                    
                    let dataContent = NSString(data: donnees, encoding: NSUTF8StringEncoding)
                    
                    let previsionsArray = dataContent?.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if previsionsArray!.count > 1 {
                        
                        isValid = true
                        let previsions = previsionsArray![1].componentsSeparatedByString("</span>")
                        
                        let previsionsText = previsions[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.previsionLabel.text = previsionsText
                        })
                        
                    }
                    
                }
                
            } // request
            
            request.resume()
            
        } // if
        
        if isValid == false {
            self.previsionLabel.text = "Incorrect Entry"
        }
    }

}

