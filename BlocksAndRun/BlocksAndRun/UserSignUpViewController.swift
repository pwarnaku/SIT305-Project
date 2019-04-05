//
//  UserSignUpViewController.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 5/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit

class UserSignUpViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    @IBOutlet weak var txtUserPasswordRe: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let userName = txtUserName.text;
        let userEmail = txtUserEmail.text;
        let userPassword = txtUserPassword.text;
        let userPasswordRe = txtUserPasswordRe.text;
    
    //check for empty fields
    
        if(userName?.isEmpty)! || (userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userPasswordRe?.isEmpty)!
    {
        //Display an alert message
        
        displayAlertMessage(userMessage: "All fields are reuired");
    
        return;
    }
    
    //check if passwords match
    
    if (userPassword != userPasswordRe)
    {
        //display an alert message
        displayAlertMessage(userMessage: "Passwords don't match");
        
     
        return ;
    }
        
    //store data
        
    //display alert message
    
    }

    func displayAlertMessage(userMessage:String)
    {
        var alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil);
        
        alert.addAction(okAction);
        
        self.present(alert, animated: true, completion: nil);
        
        
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
