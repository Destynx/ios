//
//  RootObject.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class RootObject: Decodable {
    public var results : [Article]
    public var nextId : Int
    
    enum CodingKeys: String, CodingKey{
        case results = "Results"
        case nextId = "NextId"
    }
}
