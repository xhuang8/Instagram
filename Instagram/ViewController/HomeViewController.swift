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
//import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
  
    var posts: [PFObject] = []
    //var postposts: [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.title = "Home"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight  = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchHome()
        //self.tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchHome(completion: {(success: Bool, error: Error?) -> Void in
            if success {
                print ("successfully received data")
            } else {
                print (error?.localizedDescription ?? "no error")
            }
        })
        
    }*/
  
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
       fetchHome()
      // refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogout(_ sender: Any) {
         self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    func fetchHome()
    {
        // construct query
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        query?.findObjectsInBackground{ (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                //print("Posts are: ", posts)
                //self.postposts = posts
                self.posts = posts
               // self.tableView.reloadData()
               // completion(true, nil)
            } else if let error = error {
                print(error.localizedDescription)
               // print("Error! : ", error?.localizedDescription ?? "No localized description for error")
                // handle error
               // completion(false, error)
            }
            self.tableView.reloadData()
        }
        self.refreshControl.endRefreshing()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
       
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        //let post = posts[indexPath.row]
        cell.instagramPost = posts[indexPath.row]
        return cell
       /* if let imageFile : PFFile = post.media {
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
        return cell*/
    }

}
