/*
 * @author Tyler Brockett
 * @project CSE 394 Lab 2
 * @version February 2, 2016
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Tyler Brockett
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import UIKit

class ThirdViewController: UIViewController {
    
    var firstMessage:String = ""
    var secondMessage:String = ""
    
    var default_height: CGFloat = 0.0
    
    @IBOutlet weak var labelFirstMessage: UILabel!
    @IBOutlet weak var labelSecondMessage: UILabel!
    @IBOutlet weak var finalMessage: UILabel!
    
    @IBOutlet weak var thirdMessage: UITextField!
    
    @IBAction func thirdMessageEdited(sender: UITextField) {
        updateFinalMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.default_height = self.view.frame.origin.y

        labelFirstMessage.text = firstMessage
        labelSecondMessage.text = secondMessage
        updateFinalMessage()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateFinalMessage() {
        var third: String = ""
        if let t:String = thirdMessage.text! {
            third = t
        }
        finalMessage.text = firstMessage + "\n" + secondMessage + "\n" + third
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
        self.thirdMessage.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.thirdMessage.resignFirstResponder()
        return true
    }
}

