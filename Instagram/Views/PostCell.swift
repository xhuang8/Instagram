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

    
    @IBOutlet weak var postImageView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
   
    
    var instagramPost: PFObject!{
        didSet{
            self.postImageView.file = instagramPost["image"] as? PFFile
            self.postImageView.loadInBackground()
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
