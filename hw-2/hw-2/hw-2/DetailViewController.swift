/*
 * @author              Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course              ASU CSE 394
 * @project             Homework 2
 * @version             February 25, 2016
 * @project-description Combines photo handling and database/coredata operations to store places the user has visited.
 * @class-name          DetailViewController.swift
 * @class-description   Handles creating a new Place, or editing details of an existing Place.
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
import CoreData

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var place:Place? = nil
    
    var active:AnyObject? = nil
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var descTV: UITextView!
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var defaultHeight:CGFloat = 0
    
    @IBAction func selectImageButton(sender: AnyObject) {
        let photoPicker = UIImagePickerController ()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        // display image selection view
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.defaultHeight = self.view.frame.origin.y
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    
        nameTF.delegate = self
        descTV.delegate = self
    
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "save")
        self.navigationItem.rightBarButtonItem = addButton
        
        let image = UIImage(named: "default.jpg")
        imageIV.image = image
        
        if place != nil {
            load()
        }
    }
    
    func load() {
        let image = UIImage(data: place!.pic! as NSData)
        nameTF.text = place!.name!
        descTV.text = place!.desc!
        imageIV.image = image
    }
    
    func save() {
        if nameTF.text == "" || descTV.text == "" || imageIV.image == nil {
            NSLog("Error: Not all info was filled out or selected.")
            return
        }
        
        // Place doesn't exist yet, create it and insert it into database/coredata
        if place == nil {
            let ent = NSEntityDescription.entityForName("Place", inManagedObjectContext: self.context)
            place = Place(entity: ent!, insertIntoManagedObjectContext: self.context)
        }
        
        place!.name = nameTF.text
        place!.desc = descTV.text
        place!.pic = UIImagePNGRepresentation(imageIV.image!)
        
        do {
            try self.context.save()
        } catch _ {
            NSLog("Error saving data.")
        }
        navigationController!.popViewControllerAnimated(true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker .dismissViewControllerAnimated(true, completion: nil)
        imageIV.image=image
    }
    
    // Keyboard Show functions
    func keyboardWillShow(sender: NSNotification) {
        if (nameTF == (active as? UITextField)) {
            print("nameTF was clicked!")
        }
        /* THIS DOESN'T WORK! Don't know why... So I reverted to using a plain "else"
        else if (descTV == (active as? UITextView)) */
        else {
            print("descTV was clicked!")
            self.view.frame.origin.y = self.defaultHeight - 200
        }
        print("Keyboard Shown")
    }
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = self.defaultHeight
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent:event)
        view.endEditing(true)
        self.nameTF.resignFirstResponder()
        self.descTV.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.nameTF.resignFirstResponder()
        self.descTV.resignFirstResponder()
        return true
    }
    
    // Voodoo junk to make view move up ONLY for the TextView, NOT TextField.
    func textFieldDidBeginEditing(textField: UITextField){ active = nameTF }
    func textFieldDidEndEditing(textField: UITextField){ active = nil }
    func textViewDidBeginEditing(textView: UITextView){ active = descTV }
    func textViewDidEndEditing(textView: UITextView){ active = nil }
}
