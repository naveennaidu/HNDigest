//
//  HomeViewController.swift
//  Hacker News Digest
//
//  Created by Naveennaidu Mummana on 2020/01/15.
//  Copyright © 2020 Naveennaidu Mummana. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var TableData:Array<Int> = Array <Int>()
    let cellReuseIdentifier = "post"
    
    @IBOutlet weak var topStoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFrom(Url: "https://hacker-news.firebaseio.com/v0/topstories.json")
        topStoriesTableView.dataSource = self
        topStoriesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = String(TableData[indexPath.row])
        return cell
    }
    

    func getDataFrom(Url: String) {
        let url = URL(string: Url)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

           do {
              if let json = try JSONSerialization.jsonObject(with: data) as? [Int] {
                self.TableData.append(contentsOf: json)
                print(self.TableData)
                DispatchQueue.main.async {
                    self.topStoriesTableView.reloadData()
                }
              }
           } catch let error {
             print(error.localizedDescription)
           }
            
        })

        task.resume()
        
    }
}


