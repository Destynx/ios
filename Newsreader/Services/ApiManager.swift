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
        let baseURL     = URL(string: "https://inhollandbackend.azurewebsites.net")
        
       if let url = URL(string: "/api/articles", relativeTo: baseURL){
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
        let baseURL     = URL(string: "https://inhollandbackend.azurewebsites.net")
        
        if let url = URL(string: "/api/articles/\(nextId)?count=20", relativeTo: baseURL){
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
    
    func login(username : String, password : String, withSucces success: @escaping (AuthToken)->(),                      orFailure failure: (String)->()){
        let baseURL = URL(string: "https://inhollandbackend.azurewebsites.net")
        
        if let url = URL(string: "/api/users/login", relativeTo: baseURL) {
            var request = URLRequest(url: url)
            // Set headers
            
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
                        print("NO JSON CONVERSION")
                    }
                }
                
                
//                if let data = optData{
//                    print(data)
//                    let authtoken = try JSONDecoder().decode(AuthToken.self, from: data)
//
//                    success(authtoken)
//                } else {
//                    print("NO JSON CONVERSION")
//                }
            }).resume()
        }
    }
    
    func likeArticle(Authtoken : String, Id : Int){
        let baseURL = URL(string: "https://inhollandbackend.azurewebsites.net")
        
        if let url = URL(string: "/api/Articles/\(Id)/like", relativeTo: baseURL) {
            var request = URLRequest(url: url)
            // Set headers
            
            
            request.setValue("x-authtoken", forHTTPHeaderField: Authtoken)
            request.httpMethod = "PUT"
            let session = URLSession.shared;
            session.dataTask(with: request, completionHandler:{(
                optData: Data?, reponse: URLResponse?, error: Error?) -> () in
                
                if let data = optData{
                    do{
                        
                    }
                }
                
                
                //                if let data = optData{
                //                    print(data)
                //                    let authtoken = try JSONDecoder().decode(AuthToken.self, from: data)
                //
                //                    success(authtoken)
                //                } else {
                //                    print("NO JSON CONVERSION")
                //                }
            }).resume()
        }
    }
    
    func unLikeArticle(Authtoken : String, Id: Int){
    
    }
}
