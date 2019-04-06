//
//  UserSignUpViewController.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 5/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit

class UserSignUpViewController: UIViewController {
    
    @IBOutlet weak var lblSignUp: UILabel!
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
        
        UserDefaults.standard.set(userName, forKey:"userName");
        UserDefaults.standard.set(userEmail, forKey:"userEmail");
        UserDefaults.standard.set(userPassword, forKey:"userPassword");
        UserDefaults.standard.synchronize();
        
        //display alert message
        
        let alert = UIAlertController(title: "Alert", message: "Registration is completed", preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
            action in self.dismiss(animated: true, completion: nil);
        }
        alert.addAction(okAction);
        self.present(alert, animated: true, completion: nil);
        
        
        
    }
    
    //function for alert messages
    
    func displayAlertMessage(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil);
        
        alert.addAction(okAction);
        
        self.present(alert, animated: true, completion: nil);
        
        
        
    }
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        
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
