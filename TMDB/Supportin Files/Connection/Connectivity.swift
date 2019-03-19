//
//  Connectivity.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 19/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
