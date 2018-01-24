//
//  WebService.swift
//  Les 1
//
//  Created by Maurice on 12/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class WebService{
    static let sharedInstance: WebService = {
        let instance = WebService()
        let manager : ApiManager = ApiManager()
        var articleList : [Article] = []
        var authToken : AuthToken!
        return instance
    }()
    private let manager : ApiManager = ApiManager()
    var articleList : [Article] = []
    var authToken : AuthToken!
    
    
    func getRootObject (withSuccess success: @escaping (RootObject)-> ()) {
        manager.getArticles(withSuccess: { (rootObject) in
            success(rootObject)
        }) { (error:String) in
            
        }
    }
    
    func getMoreRootObjects (nextId : Int, withSuccess success: @escaping (RootObject)-> ()) {
        manager.getMoreArticles(nextId: nextId, withSuccess: { (rootObject) in
            success(rootObject)
        }) { (error:String) in
            
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
    func likeArticle(Id : Int){
        manager.likeArticle(Authtoken : self.authToken.AuthToken, Id: Id)
    }
    
    func unLikeArticle(Id : Int){
        manager.unLikeArticle(Authtoken : self.authToken.AuthToken, Id: Id)
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
