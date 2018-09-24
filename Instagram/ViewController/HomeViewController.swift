//
//  HomeViewController.swift
//  Instagram
//
//  Created by XiaoQian Huang on 9/19/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Parse
//import ParseUI

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
  
    var  posts: [PFObject]!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
       // tableView.rowHeight  = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 200
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchHome()
        //self.tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }

    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
       fetchHome()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchHome()
    {
        // construct query
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("CreatedAt")
        //query.order(byDescending: "_created_at")
        //query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground(block: {(posts, err) in
            if err != nil {
                print(err?.localizedDescription as Any)
                self.refreshControl.endRefreshing()
            } else if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
        
        // fetch data asynchronously
       /* query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            //print("Got it !!")
            if let posts = posts {
                // do something with the array of object returned by the call
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
            self.refreshControl.endRefreshing()
        }
       */
    }
    
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        
        if let imageObject = post["media"] as? PFFile {
            imageObject.getDataInBackground(block: {
                (imageFile: Data!, error: Error!) -> Void in
                if error == nil {
                    let image = UIImage(data: imageFile)
                    cell.postImageView.image = image
                }
            })
        }
        
        if let caption = post["caption"] as? String {
            cell.captionLabel.text = caption
        }
        return cell
    }*/
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        if let imageObject = post["media"] as? PFFile {
            imageObject.getDataInBackground(block: {
                (imageFile: Data!, error: Error!) -> Void in
                if error == nil {
                    let image = UIImage(data: imageFile)
                    cell.postImageView.image = image
                }
            })
        }
        
        if let caption = post["caption"] as? String {
            cell.captionLabel.text = caption
        }
        return cell
    }
}

