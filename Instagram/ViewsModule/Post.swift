//
//  Post.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/23/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

//import Foundation
import Parse
import UIKit


class Post: PFObject, PFSubclassing {
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Post"
    }
    
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = PFObject(className: "Post")
        
        post["media"] = getPFFileFromImage(image: image)! // PFFile column type
        post["author"] = PFUser.current()! // Pointer column type that points to PFUser
        post["caption"] = caption!
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    /*static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        // This is the rect that we've calculated out and this is what is actually used below
        let targetRect = CGRect(origin: CGPoint.zero, size: targetSize)
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: targetRect)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsGetCurrentContext()?.interpolationQuality = .high
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }*/
    
}

