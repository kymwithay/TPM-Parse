//
//  ChatCell.swift
//  TPM Parse
//
//  Created by Samman Thapa on 1/4/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    var messages: PFObject! {
        didSet {
            messageLabel.text = messages.object(forKey: "text") as? String
            
            //let username = messages.object(forKey: "user")
            let user = messages.object(forKey: "user") as? PFUser
            if (user != nil) {
                // set username
                
                var username = user?.username
                
                userLabel.text = username
                
                let fullUsername = username?.replacingOccurrences(of: " ", with: "_")
                
                // set avatar
                if let username = fullUsername {
                    do {
                        let imageURL = URL(string: "http://api.adorable.io/avatar/200/\(username)")
                        
                        avatarImageView.af_setImage(withURL: imageURL!)
                    } catch {
                        let imageURL = URL(string: "http://api.adorable.io/avatar/200/random")!
                        avatarImageView.af_setImage(withURL: imageURL)
                    }
                }
            }
            else {
                userLabel.text = "unknown"
                let imageURL = URL(string: "http://api.adorable.io/avatar/200/unknown)")
                
                avatarImageView.af_setImage(withURL: imageURL!)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // for bubbleView
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        
        // for avatar image
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
