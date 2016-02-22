//
//  ViewController.swift
//  lab-1-part-1
//
//  Created by Tyler Brockett on 1/18/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    
    @IBAction func calculateButton(sender: UIButton) {
        
        var height: Double = 0.0
        var weight: Double = 0.0
        
        if let h = heightText.text, w = weightText.text{
            height = (h as NSString).doubleValue
            weight = (w as NSString).doubleValue
        }
        
        if height > 0 && weight > 0 {
            
            let BMI: Double = (weight / (height * height)) * 703.0
        
            /*
            You are underweight if BMI < 18 - Blue Color
            You are normal if BMI is greater than or equal to 18 and less than 25 - Green Color
            You are pre-obese if BMI is between 25 and 30 – purple Color
            You are obese if BMI is greater than 30 - red color
            */
            
            bmiLabel.text = String(format: "%.1f", BMI)
            
            if BMI >= 30 {
                // Obese RED
                bmiLabel.textColor = UIColor.redColor()
                explanationLabel.text = "You are obese"
                explanationLabel.textColor = UIColor.redColor()
            }
            else if BMI >= 25 {
                // Pre-Obese PURPLE
                bmiLabel.textColor = UIColor.purpleColor()
                explanationLabel.text = "You are pre-obese"
                explanationLabel.textColor = UIColor.purpleColor()
            }
            else if BMI >= 18 {
                // Normal GREEN
                bmiLabel.textColor = UIColor.greenColor()
                explanationLabel.text = "You are normal"
                explanationLabel.textColor = UIColor.greenColor()
            }
            else{
                // Underweight BLUE
                bmiLabel.textColor = UIColor.blueColor()
                explanationLabel.text = "You are underweight"
                explanationLabel.textColor = UIColor.blueColor()
            }
            
        }
        else{
            bmiLabel.text = "N/A"
            bmiLabel.textColor = UIColor.redColor()
            explanationLabel.text = "Error calculating BMI"
            explanationLabel.textColor = UIColor.redColor()
        }
    }
}

