//
//  HomeViewController.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/19/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
  
    var  posts: [Post] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight  = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchHome()
        //self.tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    @IBAction func onCamera(_ sender: Any) {
        performSegue(withIdentifier: "postSegue", sender: nil)
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
       fetchHome()
       refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchHome()
    {
        // construct query
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        query?.findObjectsInBackground(block: {(posts, error) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground(block: {
                (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        cell.postImageView.image = image
                    }
                }
                else{
                    print(error!.localizedDescription)
                }
            })
        }
        cell.captionLabel.text = post.caption
        return cell
    }

}
