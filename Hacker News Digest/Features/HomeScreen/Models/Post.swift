//
//  Posts.swift
//  Hacker News Digest
//
//  Created by Naveennaidu Mummana on 2020/01/16.
//  Copyright © 2020 Naveennaidu Mummana. All rights reserved.
//

import Foundation

class Post {
    var title: String
    var postUrl: String
    var point: Int
    var comment: Int
    
    init(title: String, postUrl: String, point: Int, comment: Int) {
        self.title = title
        self.postUrl = postUrl
        self.point = point
        self.comment = comment
    }
}
