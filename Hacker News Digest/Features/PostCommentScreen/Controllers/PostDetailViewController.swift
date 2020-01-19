//
//  PostDetailViewController.swift
//  Hacker News Digest
//
//  Created by Naveennaidu Mummana on 2020/01/18.
//  Copyright © 2020 Naveennaidu Mummana. All rights reserved.
//

import UIKit
import SafariServices

class PostDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = post?.title
        linkButton.setTitle(post?.postUrl, for: .normal)
        linkButton.backgroundColor = .clear
        linkButton.layer.cornerRadius = 5
        linkButton.layer.borderWidth = 1
        linkButton.layer.borderColor = UIColor.gray.cgColor
        if let pointText = post?.point {
            pointLabel.text = String("points: \(pointText)")
        } else {
            pointLabel.text = ""
        }
        if let commentText = post?.comment {
            commentLabel.text = String("comments: \(commentText)")
        } else {
            commentLabel.text = ""
        }
    }
    @IBAction func onLinkButtonPressed(_ sender: Any) {
        let urlString = (post?.postUrl)!
        if let url = URL(string: urlString), !url.absoluteString.isEmpty{
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            self.present(vc, animated: true)
        }
    }
    
}
