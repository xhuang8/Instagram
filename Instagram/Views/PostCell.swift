//
//  PostCell.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/23/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    /*var postData: PFObject? {
        didSet{
            self.captionLabel.text = postData?.value(forKey: "caption")as? String
            if let postImage = postData?.value(forKey: "media") as? PFFile{
                postImage.getDataInBackground(block: { (image: Data?, error: Error?) in
                    if error == nil{
                        self.postImageView.image = UIImage.init(data: image!)
                    }else{
                        print(error?.localizedDescription as Any)
                    }
                })
            }
        }
        
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
