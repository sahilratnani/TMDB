//
//  ConnectionService.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 17/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

enum RequestType{
    case Get
    case Post
}

typealias CompletionHandler = (Result<Data, DataResponseError>) -> Void

var controller :UIViewController?

class ConnectionService {
    
    class func getReactiveServiceCall(type: RequestType, url:String, payload:NSDictionary, completion:@escaping CompletionHandler) -> Void {
        
        let url = URLS.baseURL + url
        if Connectivity.isConnectedToInternet {
            Alamofire.request(url).responseJSON { (response) in
                TMDBUtil.log(string: "Response Received \(response.result.value.debugDescription)")
                switch response.result {
                case .success :
                    guard let data = response.data else {
                        TMDBUtil.log(string: "failed")
                        return
                    }
                    completion(Result.success(data))
                case .failure :
                    TMDBUtil.log(string: "failed")
                    completion(Result.failure(DataResponseError.network))
                }
            }
        } else {
            completion(Result.failure(DataResponseError.connectivity))
        }
        
    }

    func  hideLoader() -> Void {
        
    }
}
