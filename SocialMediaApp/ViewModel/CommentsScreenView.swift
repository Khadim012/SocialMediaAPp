//
//  CommentsScreenView.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit

class CommentsScreenView: UIView {
    
    @IBOutlet weak var tbComments: UITableView!
    
    var arrCommentsList: [commentsData]?
    var currPage = 1
    var prefetchState: PrefetchState = .idle
    var totalPages = 0
    
    func setupUI() {
        
        tbComments.rowHeight = UITableView.automaticDimension
        tbComments.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func registerCell() {

        tbComments.register(UINib(nibName: "HomeScreenCC", bundle: nil), forCellReuseIdentifier: "HomeScreenCC")
    }
}


//MARK:- WebServices
extension CommentsScreenView {
    
    func performWSToGetCommentsList() {
       
        WebServices.URLResponse("comments?page=\(currPage)", parameters: nil, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(CommentsDC.self, from: response)
                
                if let postsList = FULLResponse.data {
                    
                    if let currPage = FULLResponse.meta?.pagination?.page, currPage == 1 {
       
                        //I'm saving total data for pre loading.
                        if let total = FULLResponse.meta?.pagination?.total, total > 0 {
                            
                            self.totalPages = total
                        }
                        
                        self.arrCommentsList = postsList
                        self.currPage = self.currPage + 1
                    }
                    else{
                        
                        self.currPage = self.currPage + 1
                        self.arrCommentsList! += postsList
                    }
                    DispatchQueue.main.async {
                
                        self.tbComments.reloadData()
                    }
                    
                    //I'm using this to avoid double api request. If user will scroll fast then there are chance for double call
                    self.prefetchState = .idle
                }
            }catch let jsonerror{
                
                print("error parsing json objects",jsonerror)
            }
        }){ (error) in
        }
    }
}
