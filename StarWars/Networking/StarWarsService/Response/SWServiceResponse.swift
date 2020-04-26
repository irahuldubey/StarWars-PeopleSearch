//
//  SWServiceResponse.swift
//  StarWars
//

import Foundation

public enum SWServiceResponse {
  case success(response: Resource?)
  case failure(error: SWServiceError?)
}
