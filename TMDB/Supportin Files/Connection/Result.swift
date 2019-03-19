//
//  Result.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 17/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
  case success(T)
  case failure(U)
}
