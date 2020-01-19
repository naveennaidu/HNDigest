//
//  PostTableViewCell.swift
//  Hacker News Digest
//
//  Created by Naveennaidu Mummana on 2020/01/16.
//  Copyright © 2020 Naveennaidu Mummana. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    var actionBlock: (() -> Void)? = nil

    @IBAction func onLinkPressed(_ sender: Any) {
        actionBlock?()
    }
}
