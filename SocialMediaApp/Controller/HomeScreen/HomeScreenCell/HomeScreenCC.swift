//
//  HomeScreenCC.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit

class HomeScreenCC: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnComments: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgUser.layer.cornerRadius = imgUser.frame.size.width / 2
        imgUser.layer.borderWidth = 1.5
        imgUser.layer.borderColor = UIColor.white.cgColor
    }
    
    //I'm updating the UI for Home posts Screen
    func configPostsCell(model: PostsData) {
        
        lblId.text = "User ID: \(model.user_id ?? 0)"
        lblTitle.text = model.title ?? ""
        lblBody.text = model.body ?? ""
    }
    
    //I'm updating the UI for Comments list Screen
    func configCommentsCell(model: commentsData) {
        
        lblId.text = model.name ?? ""
        lblTitle.text = model.email ?? ""
        lblBody.text = model.body ?? ""
    }
}
