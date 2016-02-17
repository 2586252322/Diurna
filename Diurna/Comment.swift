//
//  Comment.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 24/01/2016.
//  Copyright © 2016 Nicolas Gaulard-Querol. All rights reserved.
//

import SwiftyJSON

class Comment: Item {
    let parent: String
    let deleted: Bool
    let kids: [Int]

    override init?(json: JSON) {
        self.parent = json["parent"].stringValue
        self.deleted = json["deleted"].boolValue
        self.kids = json["kids"].arrayValue.map { $0.intValue }
        super.init(json: json)
    }
}
