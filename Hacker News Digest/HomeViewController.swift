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
    
    var TableData:Array<String> = Array <String>()
    let cellReuseIdentifier = "post"
    
    @IBOutlet weak var topStoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://hacker-news.firebaseio.com/v0/topstories.json").validate().responseJSON { response in
            do {
                let storyIds = try JSON(data: response.data!).arrayObject as! Array<Int>
                
                for storyId in storyIds {
                    self.getPost(storyId: storyId)
                }
                
            } catch {
                print("JSON Error")
            }
        }
        topStoriesTableView.dataSource = self
        topStoriesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = TableData[indexPath.row]
        return cell
    }
    
    func getPost(storyId: Int) {
        AF.request("https://hacker-news.firebaseio.com/v0/item/\(storyId).json").validate().responseJSON { response in
            do {
                let title = try JSON(data: response.data!)["title"].description
                self.TableData.append(title)
                print(title)
                self.topStoriesTableView.reloadData()
            } catch {
                print("JSON Error")
            }
        }
    }
}


