//
//  Category.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class Category: Decodable {
    
    var id : Int
    var name : String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "Id"
        case name = "Name"
        
    }
}
