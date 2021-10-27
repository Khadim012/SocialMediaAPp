//
//  UserProfileModel.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit
import Foundation

class UserProfileModel: UIView {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgCoverBG: UIImageView!
    
    @IBOutlet weak var viewGradient: UIView!

    func setUserInfo(user: userData) {
        
        lblName.text = user.name ?? ""
        lblEmail.text = user.email ?? ""
        lblStatus.text = user.status ?? ""
    }
}

//MARK:- WebServices
extension UserProfileModel {
    
    func performWSToGetUserData(userID:String) {
       
        WebServices.URLResponse("users/\(userID)", parameters: nil, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(UserDC.self, from: response)
                
                if let userData = FULLResponse.data {
                    
                    DispatchQueue.main.async {
                        
                        self.setUserInfo(user: userData)
                    }
                   
                }
            }catch let jsonerror{
                
                print("error parsing json objects",jsonerror)
            }
        }){ (error) in
        }
    }
}
