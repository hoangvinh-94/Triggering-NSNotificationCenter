//
//  ViewController.swift
//  EmbededCommunication
//
//  Created by Dan Beaulieu on 10/1/15.
//  Copyright © 2015 Dan Beaulieu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var messageField: UITextField!

    @IBAction func handleSendTapped(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        
            // add these two lines
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(sender:)) , name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(sender: NSNotification) {
        // 1
        let userInfo = sender.userInfo!
        // 2
        let keyboardSize: CGSize =
            (userInfo[UIKeyboardFrameBeginUserInfoKey]! as! NSValue).cgRectValue.size
        let offset: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey]! as! NSValue).cgRectValue.size
        // 3
        if keyboardSize.height == offset.height {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }


}

