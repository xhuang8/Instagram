//
//  ComposeViewController.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/20/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Parse



class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var uploadImageView: UIImageView!
    //var selectedImage : UIImage?
    
   // let vc = UIImagePickerController()
     var alertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // check()
        
       // vc.delegate = self
       // vc.allowsEditing = true
     //   vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
      //  self.present(vc, animated: true, completion: nil)
        
        
    //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        // postImageView.isUserInteractionEnabled = true
        // postImageView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
    uploadImageView.image = info[UIImagePickerControllerEditedImage] as! UIImage?
    dismiss(animated: true, completion: nil)
    }
   
    @IBAction func selectedImageView(_ sender: Any) {
        //Instantiate a UIImagePickerController
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func shareImage(_ sender: Any) {
        Post.postUserImage(image: uploadImageView.image, withCaption: captionField.text, withCompletion: { (success: Bool, error: Error?) -> Void in
            if (success) {
                self.alertController = UIAlertController(title: "Success", message: "Image Successfully Uploaded", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                self.alertController.addAction(cancelAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(self.alertController, animated: true, completion: nil)
                        
                    }
                })
            } else {
                // There was a problem, check error.description
                self.alertController = UIAlertController(title: "Error", message: "\(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                self.alertController.addAction(cancelAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(self.alertController, animated: true, completion: nil)
                        
                    }
                })
            }
        })
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
