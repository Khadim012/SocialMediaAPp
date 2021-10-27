//
//  HomeScreenModel.swift
//  SocialMediaApp
//
//  Created by Khadim Hussain on 27/10/2021.
//

import UIKit
import Foundation

enum PrefetchState {
    case fetching
    case idle
}

class HomeScreenModel: UIView {
    
    @IBOutlet weak var tbPosts: UITableView!
    
    var arrPostsList: [PostsData]?
    var currPage = 1
    var prefetchState: PrefetchState = .idle
    var totalPages = 0
    
    func setupUI() {
        
        tbPosts.rowHeight = UITableView.automaticDimension
        tbPosts.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func registerCell() {

        tbPosts.register(UINib(nibName: "HomeScreenCC", bundle: nil), forCellReuseIdentifier: "HomeScreenCC")
    }
}

//MARK:- WebServices
extension HomeScreenModel {
    
    func performWSToGetPostsList() {
       
        WebServices.URLResponse("posts?page=\(currPage)", parameters: nil, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(PostsListDC.self, from: response)
                
                if let postsList = FULLResponse.data {
                    
                    if let currPage = FULLResponse.meta?.pagination?.page, currPage == 1 {
       
                        //I'm saving total data count for pre loading.
                        if let total = FULLResponse.meta?.pagination?.total, total > 0 {
                            
                            self.totalPages = total
                        }
                        self.arrPostsList = postsList
                        self.currPage = self.currPage + 1
                   
                    }
                    else{
                        
                        self.currPage = self.currPage + 1
                        self.arrPostsList! += postsList
                    }
                    DispatchQueue.main.async {
                        
                        self.tbPosts.reloadData()
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
