//
//  CommentsScreenVC.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit

class CommentsScreenVC: UIViewController {

    @IBOutlet weak fileprivate var commentsScreenView: CommentsScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentsScreenView.setupUI()
        
        //I'm using same UI for comments and home scree. I do it for code resublity. we can also creat speate according to our design
        self.commentsScreenView.registerCell()
        
        //API Called 
        self.commentsScreenView.performWSToGetCommentsList()
    }
    
    //MARK:- BUTTON ACTION
    @IBAction func didTapBackAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK:- UITableView Delegates & DataSource
extension CommentsScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let postsList = self.commentsScreenView.arrCommentsList {
            
            return postsList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCC") as? HomeScreenCC{
       
            if let commentsList = self.commentsScreenView.arrCommentsList {
                
                let comments = commentsList[indexPath.row]
                cell.configCommentsCell(model: comments)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let commentsList = self.commentsScreenView.arrCommentsList {

            //I'm preloading the next data when half list is scrolled because if user will scroll fast he will not get lagging issue. Otherwise we can also load the next data before some item and at the end of the list
            if commentsList.count > 0 && indexPath.item >= commentsList.count / 2 && commentsList.count < self.commentsScreenView.totalPages {

                if self.commentsScreenView.prefetchState == .idle {

                  //print("Pre loading...)
                    self.commentsScreenView.prefetchState = .fetching
                    self.commentsScreenView.performWSToGetCommentsList()
                }
            }
        }
    }
}
