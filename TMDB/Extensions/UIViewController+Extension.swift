//
//  UIViewController+Extension.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 19/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionTitle: String, callback: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {
            alertAction in
            callback()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
