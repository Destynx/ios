//
//  AuthToken.swift
//  Les 1
//
//  Created by Maurice on 05/11/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class AuthToken: Decodable {
    var AuthToken : String
 
    enum CodingKeys: String, CodingKey
    {
        case AuthToken = "AuthToken"
        
    }
}
