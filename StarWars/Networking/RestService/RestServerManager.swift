//
//  RestServiceManager.swift
//  StarWars
//

import Foundation

typealias RestServerResultCompletionHandler = (RestResult) -> ()

public final class RestServerManager {
    
  init() {  }
    
  /// HTTP GET Request to make a service call
  ///
  /// - Parameters:
  ///   - urlString: url for service
  ///   - completionHandler: is of type RestServerResultCompletionHandler
  ///   - errorHandler: Throw and Error
  
  func makeHTTPGETRequest(withURLString urlString: String, completionHandler completion: @escaping RestServerResultCompletionHandler) {

    guard urlString.count > 0,
      let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let url = URL.init(string: encodedURLString) else {
        print("Class: RestServer, Function: makeHTTPGETRequest - Empty URL String") // Add to Logger API Later
        return
    }
    
    let defaultSession = URLSession(configuration: .default)
    let urlRequest = RestAPIHelper.getURLRequest(with: url)
    let dataTask = defaultSession.dataTask(with: urlRequest) { (data,response,error) in
      if let data = data {
        completion(.success(data: data))
      }
      if let error = error {
        completion(.failure(error: error))
      }
    }
    dataTask.resume()
  }
}
