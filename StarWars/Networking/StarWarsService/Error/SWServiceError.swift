//
//  SWServiceError.swift
//  StarWars
//

import Foundation

public enum SWServiceErrorCodes: Int {
  
  case invalidQuery = 404
  case invalidParameters = 400
  case defaultError
  case hostNameNotFound = 1003
  
  var displayMessage: String {
    switch self {
    case .defaultError: return "Unable to get data, please try later"
    case .invalidParameters: return "Invalid Parameters"
    case .invalidQuery: return "Invalid Query"
    case .hostNameNotFound: return "HOST name not found"
    }
  }
}


public struct SWServiceError {

  public let errorCode: Int
  public let errorDescription: String
  
  public var displayError: String {
    get {
      switch errorCode {
      case 404:
        return SWServiceErrorCodes.invalidQuery.displayMessage
      case 400:
        return SWServiceErrorCodes.invalidParameters.displayMessage
      case 1003:
        return SWServiceErrorCodes.hostNameNotFound.displayMessage
      default:
        return errorDescription //Handle other cases as well as of now display Error Description as default
      }
    }
  }
  
  public init(with errorCode: Int, errorDescription: String) {
    self.errorCode = errorCode
    self.errorDescription = errorDescription
  }
}
