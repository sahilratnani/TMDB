//
//  ViewController.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 17/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = "movie/popular?api_key=722e727142324b59fe7a03f5206658a1&language=en-US&page=2"
        ConnectionService.getReactiveServiceCall(type: .Get, url:url , payload: [:]) { (responseDict) in
            print("callback received")
        }
    }


}

