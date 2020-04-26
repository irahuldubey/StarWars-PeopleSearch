//
//  RestAPIHelper.swift
//  StarWars
//

import Foundation

struct RestAPIHelper {
  static func searchURL(with attribute: AttributeType, andQueryString searchString: String, page: String) -> String? {
    var urlComponents = URLComponents()
    urlComponents.scheme = API.scheme.rawValue
    urlComponents.host = API.host.rawValue
    urlComponents.path = "/api/\(attribute.rawValue)/"
    urlComponents.queryItems = [
      URLQueryItem(name: "search", value: searchString),
      URLQueryItem(name: "page", value: page),
    ]
    return urlComponents.url?.absoluteString
  }
  
  // External API to fetch Image Service
  static func getCharacterImageAPI(with id: String) -> String {
    return "https://cdn.rawgit.com/akabab/starwars-api/0.2.1/api/id/\(id).json"
  }
  
  //Create a URL Request with the given URL
  static func getURLRequest(with url: URL) -> URLRequest {
    var request = URLRequest.init(url: url)
    request.httpMethod = RequestType.GET.rawValue
    request.timeoutInterval = Double(HTTPHeaderField.timeOut.rawValue)!
    request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    request.addValue(HTTPHeaderField.applicationJSON.rawValue,
                     forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    return request
  }
}


