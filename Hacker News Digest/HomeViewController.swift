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

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var TableData:Array<Posts> = Array <Posts>()
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PostTableViewCell
        cell.postTitleLabel.text = TableData[indexPath.row].title
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
        postDetailViewController.titleLabel = self.TableData[index].title
    }
    
    func getPost(storyId: Int) {
        AF.request("https://hacker-news.firebaseio.com/v0/item/\(storyId).json").validate().responseJSON { response in
            do {
                let json = try JSON(data: response.data!)
                let title = json["title"].description
                let point = json["score"].int
                let comment = json["descendants"].int
                self.TableData.append(Posts(title: title, point: point ?? 0, comment: comment ?? 0))
                self.topStoriesTableView.reloadData()
            } catch {
                print("JSON Error")
            }
        }
    }
}


