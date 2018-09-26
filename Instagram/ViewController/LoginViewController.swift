//
//  LoginViewController.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/17/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func emptyAlert(){
        let alertController = UIAlertController(title: "Empty Username And Password", message: "Please enter your username and password", preferredStyle: .alert)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func existAlert(){
        let alertController = UIAlertController(title: "User has already existed", message: "Please enter a valid username", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func onSignin(_ sender: Any) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if let error = error {
                if username.isEmpty || password.isEmpty{
                    self.emptyAlert()
                }
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
                if((newUser.username?.isEmpty)! || (newUser.password?.isEmpty)!){
                    self.emptyAlert()
                }
                switch error._code{
                case 202:
                    self.existAlert()
                    break
                default:
                    break
                }
                print(error.localizedDescription)
            }else {
                print("Create a new account")
               // self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

  

}
