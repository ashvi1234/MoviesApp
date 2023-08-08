//
//  MoviesRestClient.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 08/08/23.
//
import UIKit
import Alamofire
import SwiftyJSON

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}

enum RequestType : String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

/// If you have base url so please add here and appent endpoint url after that.ÃŸ
let SERVER_URL  : String = ""

class MoviesRestClient {
    
    func callApi(api :String, completion: @escaping (Result<JSON, ErrorResult>) -> Void, type: RequestType, data:Any? = nil , isAbsoluteURL:Bool = false , headers : Any? = nil, isSilent : Bool = false, jsonSerialize : Bool? = true) {
        
        guard let url = URL(string:api) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        /// Add parameter to httpBody!
        if data != nil && (jsonSerialize ?? true) {
            request.httpBody = try! JSONSerialization.data(withJSONObject: data! , options: [])
        } else if data != nil {
            request.httpBody = data as? Data
        }
        
        AF.request(request as URLRequestConvertible).responseJSON() { response in
            switch response.result {
            case .success(let value):
                completion(.success(JSON(value)))
            case .failure(let error):
                let customError = passErrorCode(andReturn: error as NSError)
                completion(.failure(.custom(string: "An error occured during request : \(customError.localizedDescription)")))
            }
        }
        
    }
    
    func callSecureAPI(api :String,completion: @escaping (Result<JSON, ErrorResult>)->Void, type:RequestType, data:Any? = [String:AnyObject]() , isAbsoluteURL:Bool = false,isSilent :Bool = false, jsonSerialize : Bool? = true, headers : Any? = nil) {
        let requestType = type
        let parameters = data
        
        var url = "" ;
        var userId = "0";
        if let temp =  UserDefaults.standard.value(forKey: "userId")  as? String {
            userId = temp;
        }
        
        let headersObject =  ["Content-Type" : "application/json", "Authorization" : nil]
        url = api.replacingOccurrences(of: "{{userId}}", with: userId)
        print("url-------->",url)
        
        self.callApi(api: url, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData) :
                    completion(result)
                case .failure(let error) :
                    //                    completion(nil)
                    //                    SVProgressHUD.dismiss()
                    //                    onErrorHandling?(error)
                    print("error --->",error)
                }
            }
        }, type: requestType, data: parameters, isAbsoluteURL: true, headers : headersObject , isSilent: isSilent, jsonSerialize: jsonSerialize)
        
    }
    
}

