//
//  ServiceManager.swift
//  WeatherApp
//
//  Created by Software Merchant on 1/10/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebServiceManager: NSObject {
    
    class func loginUser(username: String, password: String,completionHandler:@escaping (Bool, LoginModel, String)->()) {
        
        let url = Constants.urlHost+Constants.urlLogin
        let param = ["Username":username, "Password":password]
        
        self.fetchData(fromURL: url, parameter: param as [String : AnyObject], completionHandler: { (isSuccess, responseData, error) in
            
            var loginModel = LoginModel(fromDictionary: NSDictionary())
            if isSuccess {
                
                let jsonData = responseData as! NSDictionary
                
                if jsonData["username"] != nil {
                    // now val is not nil and the Optional has been unwrapped, so use it
                    loginModel = LoginModel(fromDictionary: jsonData)
                    completionHandler(true,  loginModel, "")
                }
                else {
                    completionHandler(false, loginModel,jsonData["reason"] as! String)
                }
            }
            else{
                completionHandler(false, loginModel, error)
            }
        })
    }
    
    class func forgotPassword(email: String,completionHandler:@escaping (Bool, String)->()) {
        
        let url = Constants.urlHost+Constants.urlForgotPassword
        let param = ["Email":email,]
        
        self.fetchData(fromURL: url, parameter: param as [String : AnyObject], completionHandler: { (isSuccess, responseData, error) in
            
            if isSuccess {
                let jsonData = responseData as! NSDictionary
                let result = jsonData["Result"] as! String
                if result == "sent" {
                    completionHandler(true, result)
                }
                else{
                    completionHandler(false, result)
                }
            }
            else{
                completionHandler(false, error)
            }
        })
    }
    
    class func signup(username:String, password:String, email: String, schoolname:String, avatar: Bool, avatarURl:String, completionHandler:@escaping(Bool, AnyObject, String)->()) {
        
        let url = Constants.urlHost+Constants.urlSignup
        let params = ["Password":password,
                      "Username":username,
                      "Email":email,
                      "SchoolName":schoolname,
                      "Avatar":avatar ? "true" : "false",
                      "Avatarimageurl":avatarURl]
        
        self.fetchData(fromURL: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            if isSuccess {
                let jsonData = responseData as! NSDictionary
                print(jsonData)
                completionHandler(true, jsonData, "")
            }
            else {
                completionHandler(false, "" as AnyObject, error)
            }
        })
    }
    
    
    
    
    class func fetchData(fromURL url:String, parameter param:[String:AnyObject], completionHandler:@escaping (Bool, AnyObject, String)->()) {
        
        var header: HTTPHeaders = ["Content-Type":"application/json"]
        header["Accept"] = "application/json"
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                
                if (response.result.value != nil) {
                    completionHandler(true,  response.result.value as AnyObject, "")
                }
                else{
                    completionHandler(false, "" as AnyObject, (response.error?.localizedDescription)!)
                }
        }
    }
        
        
        // MARK: Default way to call WS
        
        /*
         
         //create the session object
         let session = URLSession.shared
         
         //now create the URLRequest object using the url object
         var request = URLRequest(url: url)
         request.httpMethod = "POST" //set http method as POST
         
         do {
         request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
         
         } catch let error {
         print(error.localizedDescription)
         }
         
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
         
         //create dataTask using the session object to send data to the server
         let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
         
         guard error == nil else {
         return
         }
         
         guard let data = data else {
         return
         }
         
         do {
         //create json object from data
         if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
         print(json)
         // handle json...
         }
         
         } catch let error {
         print(error.localizedDescription)
         }
         })
         task.resume()
         
         }
         */
        
        /*
         func weatherDataOfCity(city: String, completionHandler:@escaping (Bool, RootClass, String) -> ()) {
         
         var strUrl:String = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&mode=json&units=metric&cnt=16&appid=27415d274850f186fa3de020d5fbbc28"
         strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
         
         guard let url = URL(string: strUrl) else {
         print("Error to create URL")
         return
         }
         
         WebServiceFactory.responseInDictionary(url: url, complitionHandler: {(isSuccess, dictData, message) -> () in
         
         if !isSuccess {
         print(message)
         completionHandler(false, RootClass(), message)
         }
         else {
         
         let result = RootClass(fromDictionary: (dictData as? NSDictionary)!)
         completionHandler(true, result, "Success")
         }
         })
         }
         */
}
