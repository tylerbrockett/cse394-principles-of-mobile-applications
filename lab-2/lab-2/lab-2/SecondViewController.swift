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

class SecondViewController: UIViewController {
    
    @IBOutlet weak var secondMessage: UITextField!
    @IBOutlet weak var labelFirstMessage: UILabel!
    
    var default_height: CGFloat = 0.0
    var firstMessage:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.default_height = self.view.frame.origin.y

        labelFirstMessage.text = firstMessage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toThirdViewController"
        {
            if let thirdViewController: ThirdViewController = segue.destinationViewController as? ThirdViewController {
                if let message: String = secondMessage.text!{
                    thirdViewController.secondMessage = message
                    thirdViewController.firstMessage = firstMessage
                }
            }
        }
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
        self.secondMessage.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.secondMessage.resignFirstResponder()
        return true
    }
}