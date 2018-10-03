//
//  LoginViewController.swift
//  chat
//
//  Created by LinuxPlus on 10/2/18.
//  Copyright © 2018 LinuxPlus. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
                newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "User sign up failed: \(error.localizedDescription)", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true)
            
            } else {
                print("User Registered successfully")
                self.loginUser()
            }
        }
    }
    func loginUser() {
        
        let username = usernameField.text
        let password = passwordField.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "User log in failed: \(error.localizedDescription)", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true)
                
            } else {
                print("User logged in successfully")
               self.performSegue(withIdentifier: "loginSegue", sender: nil)              }
        }   
    }
    

    @IBAction func onSignIn(_ sender: Any) {
        loginUser()
    }
    @IBAction func onSignUp(_ sender: Any) {
        if (usernameField.text!.isEmpty || passwordField.text!.isEmpty)
        {
            let alertController = UIAlertController(title: "Error", message: "Username and Password cannot be blank", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
            
            
            
        } else {
        
        registerUser()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
