//
//  ViewController.swift
//  lab-1-part-2
//
//  Created by Tyler Brockett on 1/18/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBAction func heightUpdated() {
        heightLabel.text = String(format: "%.1f", heightSlider.value) + " in"
        calculate()
    }
    
    @IBAction func weightUpdated() {
        weightLabel.text = String(format: "%.1f", weightSlider.value) + " lbs"
        calculate()
    }
    
    func calculate() {
        let height: Float = heightSlider.value
        let weight: Float = weightSlider.value
        let BMI: Float = (weight / (height * height)) * 703.0
            
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
}
