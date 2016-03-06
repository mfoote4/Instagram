//
//  HomeCell.swift
//  Instagram
//
//  Created by Michaela Foote on 3/5/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeCell: UITableViewCell {

    @IBOutlet weak var pictureView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var fullPost: PFObject! {
        didSet{
            self.captionLabel.text = fullPost["caption"] as! String?
            let picture = fullPost["picture"] as! PFObject
            self.pictureView.file = picture["image"] as? PFFile
            self.pictureView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
