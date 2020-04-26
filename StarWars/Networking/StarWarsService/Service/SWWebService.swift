//
//  StarWarWebService.swift
//  StarWars
//

import Foundation

public final class SWWebService: SWWebServiceAPI {
  
  private let serverManager: RestServerManager!
  
  public init() {
    serverManager = RestServerManager()
  }

  
  /// Fetch People Resource
  /// - Parameters:
  ///   - queryString: people name to search
  ///   - page: page number to fetch
  ///   - completion: Response as error or Resource
  /// - Returns: Void
  public func fetchPeopleResource(withSearchQuery queryString: String, page: String, withCompletionHandler completion: @escaping (SWServiceResponse) -> ()) throws {
    
    guard let urlString = RestAPIHelper.searchURL(with: .people, andQueryString: queryString, page: page) else { return }

     serverManager.makeHTTPGETRequest(withURLString: urlString) { (result) in
       switch result {
        
       case .success(data: let data):
        
        guard let data = data else { return }
        let allData = SWServiceParser.parseResourceJson(data: data)
        completion(.success(response: allData))

       case .failure(error: let errorResonse):
        
         guard let error = errorResonse else {
           completion(.failure(error: nil))
           return
         }
         let wsError = SWServiceParser.parseSWServiceError(from: error)
         completion(.failure(error: wsError))
       }
     }
  }
  
  
  /// Fetch Image for the given people id
  /// - Parameters:
  ///   - id: people id from Star Wars People API
  ///   - completion: Image Data
  /// - Returns: Void
  public func fetchImage(with id: String, completionHandler completion: @escaping (Data?) -> ()) {
      
    let jsonString = RestAPIHelper.getCharacterImageAPI(with: id)
    var imageURL: String?
  
    // Get JSON data for the selected people id
    serverManager.makeHTTPGETRequest(withURLString: jsonString) { (result) in
      
      switch result {
        
      case .success(data: let data):
        
        guard let data = data else { return }
        let imageData = SWServiceParser.parseImageJson(data: data)
        imageURL = imageData?.image
        // Get Image for the given Image URL
        if let imageURL = imageURL {
          self.serverManager.makeHTTPGETRequest(withURLString: imageURL) { (result) in
            switch result {
            case .success(data: let data):
              completion(data)
            case .failure(error: _):
              completion(nil)
            }
          }
        } else {
          completion(nil)

        }
        
      case .failure(error: _):
        completion(nil)
      }
    }
  }
}
