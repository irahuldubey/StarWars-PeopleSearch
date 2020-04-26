//
//  StarWebServiceAPI.swift
//  StarWars
//

import Foundation

public protocol SWWebServiceAPI {
  
  func fetchPeopleResource(withSearchQuery queryString: String, page: String, withCompletionHandler completion: @escaping (SWServiceResponse) -> ()) throws -> Void
  
  func fetchImage(with id: String, completionHandler completion: @escaping (Data?) -> ()) throws -> Void
  
}
