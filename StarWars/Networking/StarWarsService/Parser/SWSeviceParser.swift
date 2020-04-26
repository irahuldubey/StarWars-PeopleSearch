//
//  StarWarSeviceParser.swift
//  StarWars
//

import Foundation

final class SWServiceParser {
  
  static func parseSWServiceError(from error: Error) -> SWServiceError {
    let nsError = error as NSError
    return SWServiceError.init(with: nsError.code, errorDescription: nsError.localizedDescription)
  }
  
  static func parseResourceJson(data: Data) -> Resource? {
    let decoder = JSONDecoder()
    do {
      let allResources = try decoder.decode(Resource.self, from: data)
      return allResources
    } catch {
      print(error)
      return nil
    }
  }
  
  static func parseImageJson(data: Data) -> ImageModel? {
     let decoder = JSONDecoder()
     do {
       let allImageJSONResponse = try decoder.decode(ImageModel.self, from: data)
       return allImageJSONResponse
     } catch {
       return nil
     }
   }
}
