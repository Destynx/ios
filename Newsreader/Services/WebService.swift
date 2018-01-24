//
//  WebService.swift
//  Les 1
//
//  Created by Maurice on 12/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class WebService{
    private let manager : ApiManager = ApiManager()
    
    var articleList : [Article] = []
    var authToken : AuthToken!
    
    func getRootObject (withSuccess success: @escaping (RootObject)-> ()) {
        if (self.isLoggedIn()) {
            self.manager.getArticles(authToken: self.authToken.AuthToken, withSuccess: { (rootObject) in
                success(rootObject)
            }, orFailure: {(error) in })
        } else {
            self.manager.getArticles(authToken: "", withSuccess: { (rootObject) in
                success(rootObject)
            }, orFailure: {(error) in })
        }
    }
    
    func getMoreRootObjects (nextId : Int, withSuccess success: @escaping (RootObject)-> ()) {
        if (self.isLoggedIn()) {
            manager.getMoreArticles(nextId: nextId, authToken: self.authToken.AuthToken, withSuccess: { (rootObject) in
                success(rootObject)
            }, orFailure: {(error) in })
        } else {
            manager.getMoreArticles(nextId: nextId, authToken: "", withSuccess: { (rootObject) in
                success(rootObject)
            }, orFailure: {(error) in })
        }
    }

    func executeLogin (username : String, password : String, withSuccess success: @escaping (Bool)-> (), orFailure failure: @escaping (Bool)-> ()) {
        manager.login(username: username, password : password, withSucces: { (AuthToken) in
            self.authToken = AuthToken
            success(true)
        }, orFailure: { (error) in
            failure(false)
        })
    }
    
    func likeArticle(Id : Int, like : Bool){
        manager.likeArticle(Authtoken : self.authToken.AuthToken, Id: Id, like : like)
    }
    
    func isLoggedIn() -> Bool {
        if (authToken != nil) {
            if (authToken.AuthToken != "") {
                return true
            }
        }
    
        return false
    }
    
    func logout(){
        authToken = nil;
    }
}
