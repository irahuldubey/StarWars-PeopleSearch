//
//  DataError.swift
//  StarWars
//
//  Copyright © 2020 SW. All rights reserved.
//

import Foundation

//MARK: - API Data Error
public enum DataError: Error {
  /// This case is returned when we get an unexpected response from a service
  case invalidResponse
  /// This case is returned in all errors when accessing API.
  case invalidJSONData
  /// This case returns when we dont have complete information from the service.
  case incompleteData
}
