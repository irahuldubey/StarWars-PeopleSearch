//
//  DetailViewModel.swift
//  StarWars
//

import Foundation
import UIKit

internal final class DetailViewModel {
  
   private let swService: SWWebServiceAPI
   
   //MARK: - Initializer

   init(withAPI swService: SWWebServiceAPI) {
     self.swService = swService
   }

  //Create a default Global Queue
  private let imageQueue = DispatchQueue.global()
  
  public func fetchImage(with peopleObject: People?, completionHandler: @escaping (UIImage?) -> ()) {

    guard let peopleURLComponents = peopleObject?.url.split(separator: "/"),
      let peopleId = peopleURLComponents.last else {
      completionHandler(nil)
      return
    }
    
    imageQueue.async {
      do {
        try self.swService.fetchImage(with: String(peopleId)) { (response) in
          DispatchQueue.main.async {
            if let data = response {
              let imageWithData = UIImage.init(data: data)
              completionHandler(imageWithData)
            }
          }
        }
      } catch _ {
        completionHandler(nil)
      }
    }
  }
}
