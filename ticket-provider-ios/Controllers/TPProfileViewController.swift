//
//  TPProfileViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/12/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit

class TPProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        self.saveButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.saveButton.layer.shadowOffset = CGSizeMake(2, 2)
        self.saveButton.layer.shadowOpacity = 0.2
        
        self.nameTextField.tag = 0
        self.nameTextField.returnKeyType = UIReturnKeyType.Next
        self.nameTextField.delegate = self
        
        self.birthdateTextField.tag = 1
        self.birthdateTextField.returnKeyType = UIReturnKeyType.Next
        self.birthdateTextField.delegate = self
        
        self.currentPasswordTextField.tag = 2
        self.currentPasswordTextField.returnKeyType = UIReturnKeyType.Next
        self.currentPasswordTextField.delegate = self
        
        self.newPasswordTextField.tag = 3
        self.newPasswordTextField.returnKeyType = UIReturnKeyType.Next
        self.newPasswordTextField.delegate = self
        
        self.confirmPasswordTextField.tag = 4
        self.confirmPasswordTextField.returnKeyType = UIReturnKeyType.Go
        self.confirmPasswordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TPLoginViewController.DismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.addLeftBarButtonWithImage(UIImage(named: "HamburgerIcon")!)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == self.birthdateTextField.tag {
            let datePickerView  : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.Time
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(TPProfileViewController.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == self.nameTextField.tag {
            self.birthdateTextField.becomeFirstResponder()
            return true
        } else if textField.tag == self.currentPasswordTextField.tag {
            self.newPasswordTextField.becomeFirstResponder()
            return true
        } else if textField.tag == self.newPasswordTextField.tag {
            self.confirmPasswordTextField.becomeFirstResponder()
            return true
        } else if textField.tag == self.confirmPasswordTextField.tag {
            self.updateUser(self)
            return true
        }
        return false
    }
    
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        self.birthdateTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func updateUser(sender: AnyObject) {
    }
}
