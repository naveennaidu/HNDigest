//
//  HomeViewController.swift
//  Hacker News Digest
//
//  Created by Naveennaidu Mummana on 2020/01/15.
//  Copyright © 2020 Naveennaidu Mummana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SafariServices

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var TableData:Array<Post> = Array <Post>()
    let cellReuseIdentifier = "post"
    
    @IBOutlet weak var topStoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://hacker-news.firebaseio.com/v0/topstories.json").validate().responseJSON { response in
            do {
                let storyIds = try JSON(data: response.data!).arrayObject as! Array<Int>
                
                for storyId in storyIds[1...30] {
                    self.getPost(storyId: storyId)
                }
                
            } catch {
                print("JSON Error")
            }
        }
        topStoriesTableView.dataSource = self
        topStoriesTableView.delegate = self
        topStoriesTableView.rowHeight = UITableView.automaticDimension
        topStoriesTableView.estimatedRowHeight = 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //deselect selected UITableView cell
        if let index = self.topStoriesTableView.indexPathForSelectedRow{
            self.topStoriesTableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PostTableViewCell
        cell.postTitleLabel.text = TableData[indexPath.row].title
        cell.linkButton.setTitle(TableData[indexPath.row].postUrl, for: .normal)
        cell.linkButton.backgroundColor = .clear
        cell.linkButton.layer.cornerRadius = 5
        cell.linkButton.layer.borderWidth = 1
        cell.linkButton.layer.borderColor = UIColor.gray.cgColor
        cell.actionBlock = {
            let urlString = self.TableData[indexPath.row].postUrl
            if let url = URL(string: urlString), !url.absoluteString.isEmpty{
                let config = SFSafariViewController.Configuration()
                let vc = SFSafariViewController(url: url, configuration: config)
                self.present(vc, animated: true)
            }
        }
        cell.pointsLabel.text = "points: \(TableData[indexPath.row].point)"
        cell.commentsLabel.text = "comments: \(TableData[indexPath.row].comment)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "postDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let postDetailViewController = segue.destination as? PostDetailViewController,
            let index = topStoriesTableView.indexPathForSelectedRow?.row
            else {
                return
        }
        postDetailViewController.post = self.TableData[index]
    }
    
    func getPost(storyId: Int) {
        AF.request("https://hacker-news.firebaseio.com/v0/item/\(storyId).json").validate().responseJSON { response in
            do {
                let json = try JSON(data: response.data!)
                let title = json["title"].description
                let postUrl = json["url"].description
                let point = json["score"].int
                let comment = json["descendants"].int
                self.TableData.append(Post(title: title, postUrl: postUrl, point: point ?? 0, comment: comment ?? 0))
                self.topStoriesTableView.reloadData()
            } catch {
                print("JSON Error")
            }
        }
    }
}


