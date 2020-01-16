//
//  Posts.swift
//  Hacker News Digest
//
//  Created by Naveennaidu Mummana on 2020/01/16.
//  Copyright © 2020 Naveennaidu Mummana. All rights reserved.
//

import Foundation

class Posts {
    var title: String
    var point: Int
    var comment: Int
    
    init(title: String, point: Int, comment: Int) {
        self.title = title
        self.point = point
        self.comment = comment
    }
}
