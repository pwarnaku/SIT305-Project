//
//  UserSignInViewController.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 5/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit

class UserSignInViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        let userName = txtUserName.text;
        let userPassword = txtUserPassword.text;
        
        //get the data that saved in store using UserDefaults
        
        let userNameStored = UserDefaults.standard.string(forKey: "userName");
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");
        
        //check all inputs are valid or not
        
        if(userNameStored == userName){
            if(userPasswordStored == userPassword){
                
                //login is successful
                
                UserDefaults.standard.set(true, forKey:"isUserLoggedIn");
                UserDefaults.standard.synchronize();
                
                //display alert message
                
                let alert = UIAlertController(title: "Alert", message: "SignIn is completed", preferredStyle: UIAlertController.Style.alert);
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                    action in self.dismiss(animated: true, completion: nil);
                }
                alert.addAction(okAction);
                self.present(alert, animated: true, completion: nil);
                
                // link the game
                
                
                
            }
                
            else {
                
                //display alert message when password doesn't match
                
                let alert = UIAlertController(title: "Alert", message: "Password is Incorrect !! ", preferredStyle: UIAlertController.Style.alert);
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil);
                alert.addAction(okAction);
                self.present(alert, animated: true, completion: nil);
            }
        }
        else {
            
            //display alert message when user name doesn't match
            
            let alert = UIAlertController(title: "Alert", message: "Username is Incorrect !! ", preferredStyle: UIAlertController.Style.alert);
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil);
            alert.addAction(okAction);
            self.present(alert, animated: true, completion: nil);
        }
        
        
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
