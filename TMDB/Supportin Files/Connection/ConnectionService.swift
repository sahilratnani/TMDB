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

typealias CompletionHandler = (_ dictData: NSDictionary) -> Void

var controller :UIViewController?

class ConnectionService: NSObject {
    
    var delegate:ConnnectionServiceDelegate?
//    var manager :A

    init(ViewController:UIViewController){
        
        controller = ViewController
    }
    //This is AFNetworking ReactiveCocoa
    func getReactiveServiceCall(type: RequestType, url:String , payload:NSDictionary, token:String) -> Void {
        Alamofire.request("www.google.com")
        
    }

    func  hideLoader() -> Void {
        
    }
    
    func handleServiceResponse1(_ response: NSDictionary, service:String) -> Void {
        
        delegate?.handleServiceResponse1(response, service: service, code: 0)
        
    }
}
