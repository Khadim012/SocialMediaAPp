//
//  UserProfileVC.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit

class UserProfileVC: UIViewController {

    @IBOutlet weak fileprivate var userProfileView: UserProfileModel!
    var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //API Call
        self.userProfileView.performWSToGetUserData(userID: userID)
    }
    
    //MARK:- BUTTON ACTION
    @IBAction func didTapBackAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
