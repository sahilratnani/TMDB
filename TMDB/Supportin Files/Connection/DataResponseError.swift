//
//  DataResponseError.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 17/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//
import Foundation

enum DataResponseError: Error {
  case network
  case decoding
  case connectivity
    
  var reason: String {
    switch self {
    case .network:
      return "An error occurred while fetching data"
    case .decoding:
      return "An error occurred while decoding data"
    case .connectivity:
        return "OOPS! It Seems there is no internet connectivity. Please connect to the internet and try again"
    }
  }
}
