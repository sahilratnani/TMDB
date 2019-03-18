//
//  ConnectionService.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 17/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import UIKit
import Alamofire

enum RequestType{
    case Get
    case Post
}

protocol ConnnectionServiceDelegate {
    
    func handleServiceResponse1(_ response:NSDictionary, service:String, code:NSInteger)
    
}

typealias CompletionHandler = (_ dictData: Data) -> Void

var controller :UIViewController?

class ConnectionService {
    
    var delegate:ConnnectionServiceDelegate?
//    var manager :A

    init(ViewController:UIViewController){
        
        controller = ViewController
    }
    //This is AFNetworking ReactiveCocoa
    class func getReactiveServiceCall(type: RequestType, url:String , payload:NSDictionary, completion:@escaping CompletionHandler) -> Void {
        
        let url = URLS.baseURL + url
        Alamofire.request(url).responseJSON { (response) in
           
            switch response.result {
            case .success :
                print("response received \(response.result.value.debugDescription)")
                guard let data = response.data else {
                    print("failed")
                    return
                }
                completion(data)
                print("response received \(data)")
            case .failure :
                print("failed")
            }
           
//            completion(response.result)
        }
        
        
    }

    func  hideLoader() -> Void {
        
    }
    
    func handleServiceResponse1(_ response: NSDictionary, service:String) -> Void {
        
        delegate?.handleServiceResponse1(response, service: service, code: 0)
        
    }
}
