//
//  DetailViewController.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/25/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Alamofire

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBOutlet weak var captionMessage: UITextField!
    
    var postImage: UIImage?
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         imageToPost.image = postImage
        
        // imageToPost.image = postImage
        // Do any additional setup after loading the view.
    }

    @IBAction func postImage(_ sender: Any) {
        
        Post.postUserImage(image: postImage, withCaption: captionMessage.text, withCompletion: { (success: Bool, error: Error?) -> Void in
            DispatchQueue.main.async {
                
                self.imageToPost.image = nil
                self.captionMessage.text = nil
            }}
        )
        self.performSegue(withIdentifier: "toHomeSegue", sender: self)
        // dismiss(animated: true, completion: nil)
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
