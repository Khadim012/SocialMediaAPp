//
//  HomeScreenVC.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    @IBOutlet weak fileprivate var homeScreenView: HomeScreenModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeScreenView.setupUI()
        
        //I'm using same UI for comments and home scree. I do it for code resublity. we can also creat speate according to our design
        self.homeScreenView.registerCell()
        
        //API Call
        self.homeScreenView.performWSToGetPostsList()
    }
}


// MARK:- UITableView Delegates & DataSource
extension HomeScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let postsList = self.homeScreenView.arrPostsList {
            
            return postsList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCC") as? HomeScreenCC{
            
            cell.btnProfile.tag = indexPath.row
            cell.btnProfile.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
            
            cell.btnComments.tag = indexPath.row
            cell.btnComments.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        
            if let postsList = self.homeScreenView.arrPostsList {
                
                let post = postsList[indexPath.row]
                cell.configPostsCell(model: post)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func didTapProfile(sender: UIButton) {

        if let postsList = self.homeScreenView.arrPostsList {
            
            let post = postsList[sender.tag]
            let vc = UserProfileVC.instantiate(fromAppStoryboard: .Main)
            vc.userID = "\(post.user_id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didTapComments(sender: UIButton) {
        
        let vc = CommentsScreenVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let postsList = self.homeScreenView.arrPostsList {

            //I'm preloading the next data when half list is scrolled because if user will scroll fast he will not get lagging issue. Otherwise we can also load the next data before some item and at the end of the list
            if postsList.count > 0 && indexPath.item >= postsList.count / 2 && postsList.count < self.homeScreenView.totalPages {

                if self.homeScreenView.prefetchState == .idle {

                  //print("Pre loading...)
                    self.homeScreenView.prefetchState = .fetching
                    self.homeScreenView.performWSToGetPostsList()
                }
            }
        }
    }
}
