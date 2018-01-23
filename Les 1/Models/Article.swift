//
//  Article.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class Article: Decodable {
    
    var id : Int
    var feed : Int = 0
    var title : String
    var summary : String
    var publishdate : String
    var image : String
    var url : String
    var related : [String]
    var categories : [Category]
    var isliked : Bool
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case feed = "Feed"
        case title = "Title"
        case summary = "Summary"
        case publishdate = "PublishDate"
        case image = "Image"
        case url = "Url"
        case related = "Related"
        case categories = "Categories"
        case isliked = "IsLiked"
        
    }
}
