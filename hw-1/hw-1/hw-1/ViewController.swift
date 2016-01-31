//
//  ViewController.swift
//  hw-1
//
//  Created by Tyler Brockett on 1/27/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tRun: UITextField!
    @IBOutlet weak var cRun: UITextField!
    @IBOutlet weak var tStrength: UITextField!
    @IBOutlet weak var cStrength: UITextField!
    @IBOutlet weak var cFood: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var bloodPressure: UITextField!

    @IBOutlet weak var wCaloricIntake: UITextField!
    @IBOutlet weak var wCaloriesBurned: UITextField!
    @IBOutlet weak var avgBloodPressure: UITextField!
    @IBOutlet weak var weightChange: UITextField!
    
    var default_height: CGFloat = 0.0
    
    let statsHelper: StatsHelper = StatsHelper()
    
    @IBAction func submit(sender: UIButton) {
        let newDay: DailyStats = getDailyData()
        if !newDay.hasErrors(){
            statsHelper.addDailyStats(newDay)
            wCaloricIntake.text = String(statsHelper.getWeeklyCaloricIntake())
            wCaloriesBurned.text = String(statsHelper.getWeeklyCaloriesBurned())
            avgBloodPressure.text = String(statsHelper.getWeeklyAverageBloodPressure())
            if statsHelper.getWeeklyWeightChange() > 0 {
                weightChange.text = "+" + String(statsHelper.getWeeklyWeightChange())
            }
            else{
                weightChange.text = String(statsHelper.getWeeklyWeightChange())
            }
        }
        else{
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "There was an error gathering your daily data. Make sure you typed everything in correctly."
            alert.addButtonWithTitle("Okay")
            alert.show()
        }
    }
    
    func getDailyData() -> DailyStats{
        var dayRunTime: Int = -Int.max
        var dayRunCals: Int = -Int.max
        var dayStrengthTime: Int = -Int.max
        var dayStrengthCals: Int = -Int.max
        var dayFoodCals: Int = -Int.max
        var dayWeight: Int = -Int.max
        var dayBloodPressure: Int = -Int.max
        if let t = Int(tRun.text!){
            dayRunTime = t
        }
        if let t = Int(cRun.text!){
            dayRunCals = t
        }
        if let t = Int(tStrength.text!){
            dayStrengthTime = t
        }
        if let t = Int(cStrength.text!){
            dayStrengthCals = t
        }
        if let t = Int(cFood.text!){
            dayFoodCals = t
        }
        if let t = Int(weight.text!){
            dayWeight = t
        }
        if let t = Int(bloodPressure.text!){
            dayBloodPressure = t
        }
        let stats = DailyStats(tRun:dayRunTime, cRun:dayRunCals, tStrength:dayStrengthTime, cStrength:dayStrengthCals, cFood:dayFoodCals, weight:dayWeight, bloodPressure:dayBloodPressure)
        return stats
    }
    
    func error() {
        cRun.text = "Error"
        tRun.text = "Error"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.default_height = self.view.frame.origin.y
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = self.default_height - 100
    }
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = self.default_height
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent:event)
        view.endEditing(true)
        self.tRun.resignFirstResponder()
        self.cRun.resignFirstResponder()
        self.tStrength.resignFirstResponder()
        self.cStrength.resignFirstResponder()
        self.cFood.resignFirstResponder()
        self.weight.resignFirstResponder()
        self.bloodPressure.resignFirstResponder()
        self.wCaloricIntake.resignFirstResponder()
        self.wCaloriesBurned.resignFirstResponder()
        self.weightChange.resignFirstResponder()
        /*
        //or
        // Keyboard disappear when touch outside
        
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        */
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.tRun.resignFirstResponder()
        self.cRun.resignFirstResponder()
        self.tStrength.resignFirstResponder()
        self.cStrength.resignFirstResponder()
        self.cFood.resignFirstResponder()
        self.weight.resignFirstResponder()
        self.bloodPressure.resignFirstResponder()
        self.wCaloricIntake.resignFirstResponder()
        self.wCaloriesBurned.resignFirstResponder()
        self.weightChange.resignFirstResponder()
        return true
    }
}

