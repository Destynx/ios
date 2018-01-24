//
//  ApiManager.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class ApiManager {
    func getArticles(authToken : String,
                     withSuccess success: @escaping (RootObject)->(),
                     orFailure failure: (String)->()){
       if let url = URL(string: "\(API_BASE_URL)/api/articles"){
            var request = URLRequest(url: url)
            if(authToken != ""){
                request.addValue(authToken, forHTTPHeaderField: "x-authtoken" )
            }
            let session = URLSession.shared;
            session.dataTask(with: request,
                             completionHandler:{(optData: Data?,
                                response: URLResponse?,
                                error: Error?) -> () in  
                                        if let data = optData{
                                            do{
                                                let rootobject = try JSONDecoder().decode(RootObject.self, from: data)

                                                success(rootobject)
                                                
                                            }
                                            catch { }
                                }
            }).resume()
            
        }
    }
    
    func getMoreArticles(nextId : Int,
                         authToken : String,
                         withSuccess success: @escaping (RootObject)->(),
                         orFailure failure: (String)->()){
        if let url = URL(string: "\(API_BASE_URL)/api/articles/\(nextId)?count=20"){
            var request = URLRequest(url: url)
            if(authToken != ""){
                request.addValue(authToken, forHTTPHeaderField: "x-authtoken" )
            }
            let session = URLSession.shared;
            session.dataTask(with: request,
                             completionHandler:{(optData: Data?,
                                response: URLResponse?,
                                error: Error?) -> () in  
                                if let data = optData{
                                    do{
                                        let rootobject = try JSONDecoder().decode(RootObject.self, from: data)
                                        
                                        success(rootobject)
                                        
                                    } catch{ }
                                }
            }).resume()
            
        }
    }
    
    func login(username : String,
               password : String,
               withSucces success: @escaping (AuthToken)->(),
               orFailure failure: @escaping (String)->()){
        if let url = URL(string: "\(API_BASE_URL)/api/users/login") {
            var request = URLRequest(url: url)
            
            let bodyData = "username=\(username)&password=\(password)"
            request.httpBody = bodyData.data(using: String.Encoding.utf8);
            request.httpMethod = "POST"
            let session = URLSession.shared;
            session.dataTask(with: request, completionHandler:{(
                optData: Data?, reponse: URLResponse?, error: Error?) -> () in

                if let data = optData{
                    do{
                        let authtoken = try JSONDecoder().decode(AuthToken.self, from: data)
                        
                        success(authtoken)
                    }
                    catch{
                        failure("NO JSON CONVERSION")
                    }
                }
            }).resume()
        }
    }
    
    func likeArticle(Authtoken : String, Id : Int, like : Bool){
        if let url = URL(string: "\(API_BASE_URL)/api/Articles/\(Id)/like") {
            var request = URLRequest(url: url)
            // Set headers
            
            request.addValue(Authtoken , forHTTPHeaderField: "x-authtoken" )
            if(like) {
                request.httpMethod = "PUT"
            } else {
                request.httpMethod = "DELETE"
            }
            let session = URLSession.shared;
            session.dataTask(with: request, completionHandler:{(
                optData: Data?, reponse: URLResponse?, error: Error?) -> () in
                if let data = optData{ }
            }).resume()
        }
    }
}
