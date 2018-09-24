//
//  LoginViewController.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/17/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onSignin(_ sender: Any) {
        
      //  let username = usernameLabel.text ?? ""
       // let password = passwordLabel.text ?? ""
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("You successfully login!")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    
    @IBAction func onSignup(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackground{
            (success: Bool, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
            }else {
                print("Create a new account")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

  

}
