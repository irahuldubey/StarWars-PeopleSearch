//
//  RestEnumerations.swift
//  StarWars
//

import Foundation

/// RequestType : Service Request Type
///
/// - GET: GET type
/// - POST: POST type
enum RequestType: String {
  case GET
  case POST
}

/// HTTPHeaderField: Extra HTTPHeader Parameters Appended
///
/// - contentType: contentType Defined
/// - applicationJSON: JSON
/// - timeOut: timeout // Need to be changed later as per the requirement
enum HTTPHeaderField: String {
  case contentType = "Content-Type"
  case applicationJSON = "application/json"
  case timeOut = "10"
}

///
/// RestResult: Returns Success and Failure
///
/// - success: Data as success
/// - failure: Error received from server
enum RestResult {
  case success(data: Data?)
  case failure(error: Error?)
}
