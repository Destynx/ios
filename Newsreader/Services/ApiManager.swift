//
//  ApiManager.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class ApiManager {
    func getArticles(withSuccess success: @escaping (RootObject)->(),                      orFailure failure: (String)->()){
       if let url = URL(string: "/api/articles", relativeTo: API_BASE_URL){
            let session = URLSession.shared;
            session.dataTask(with: url,
                             completionHandler:{(optData: Data?,
                                response: URLResponse?,
                                error: Error?) -> () in  
                                        if let data = optData{
                                            do{
                                                print(data)
                                                let rootobject = try JSONDecoder().decode(RootObject.self, from: data)

                                                success(rootobject)
                                                
                                            }
                                            catch{
                                                print("NO JSON CONVERSION")
                                            }
                                }
            }).resume()
            
        }
    }
    
    func getMoreArticles(nextId : Int, withSuccess success: @escaping (RootObject)->(),                      orFailure failure: (String)->()){
        if let url = URL(string: "/api/articles/\(nextId)?count=20", relativeTo: API_BASE_URL){
            let session = URLSession.shared;
            session.dataTask(with: url,
                             completionHandler:{(optData: Data?,
                                response: URLResponse?,
                                error: Error?) -> () in  
                                if let data = optData{
                                    do{
                                        print(data)
                                        let rootobject = try JSONDecoder().decode(RootObject.self, from: data)
                                        
                                        success(rootobject)
                                        
                                    }
                                    catch{
                                        print("NO JSON CONVERSION")
                                    }
                                }
            }).resume()
            
        }
    }
    
    func login(username : String,
               password : String,
               withSucces success: @escaping (AuthToken)->(),
               orFailure failure: @escaping (String)->()){
        if let url = URL(string: "/api/users/login", relativeTo: API_BASE_URL) {
            var request = URLRequest(url: url)
            
            let bodyData = "username=\(username)&password=\(password)"
            request.httpBody = bodyData.data(using: String.Encoding.utf8);
            request.httpMethod = "POST"
            let session = URLSession.shared;
            session.dataTask(with: request, completionHandler:{(
                optData: Data?, reponse: URLResponse?, error: Error?) -> () in

                if let data = optData{
                    do{
                        print(data)
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
        if let url = URL(string: "/api/Articles/\(Id)/like", relativeTo: API_BASE_URL) {
            var request = URLRequest(url: url)
            // Set headers
            
            request.setValue("x-authtoken", forHTTPHeaderField: Authtoken)
            if(like) {
                request.httpMethod = "PUT"
            } else {
                request.httpMethod = "DELETE"
            }
            let session = URLSession.shared;
            session.dataTask(with: request, completionHandler:{(
                optData: Data?, reponse: URLResponse?, error: Error?) -> () in
            }).resume()
        }
    }
}
