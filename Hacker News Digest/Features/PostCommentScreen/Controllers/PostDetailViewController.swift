//
//  PostDetailViewController.swift
//  Hacker News Digest
//
//  Created by Naveennaidu Mummana on 2020/01/18.
//  Copyright © 2020 Naveennaidu Mummana. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    var titleLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel?.text = titleLabel
    }

}
