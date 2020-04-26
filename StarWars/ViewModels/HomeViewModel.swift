//
//  HomeViewModel.swift
//  StarWars
//

import Foundation

internal final class HomeViewModel {
  
  //MARK: - Properties
  
  private var resources: Resource?
  private var currentSearchText: String?
  private var nextPageNumber: String?
  private let swService: SWWebServiceAPI
  private let peopleDownloadQueue = DispatchQueue.global()

  //MARK: - Initializer

  init(withAPI swService: SWWebServiceAPI) {
    self.swService = swService
  }
  
  func fetchResults(for query: String,
                    withCompletionHandler completion: @escaping (_ res: Resource?, _ errorString: String?) -> ()) {
    
    guard !query.isEmpty else {
      return
    }
    
    currentSearchText = query
    let firstPageIndex = "1"
    peopleDownloadQueue.async {
      do {
        try self.swService.fetchPeopleResource(withSearchQuery: query,
                                               page: firstPageIndex,
                                               withCompletionHandler: {  [weak self] (serviceResponse) in
          guard let strongSelf = self else { return }
          switch serviceResponse {
          case .success(let resource):
            if let resource = resource {
              strongSelf.resources = resource
              strongSelf.nextPageNumber = Utilities.getQueryStringParameter(url: resource.next, param: "page")
              completion(resource, nil);
            } else {
              //Add to Logger Info
              completion(nil, Message.errorMessage)
            }
          case .failure(let error) :
            //Add to Logger Info
            completion(nil, error?.displayError ?? Message.errorMessage)
          }
        })
      }
      catch _ {
        //Add to Logger Info
      }
    }
  }
  
  func loadNextResults(withCompletionHandler completion: @escaping (_ people: [People]) -> ()) {
    
    guard let currentText = currentSearchText, let nextPageNumber = self.nextPageNumber else { return }
    peopleDownloadQueue.async {
      do {
        try self.swService.fetchPeopleResource(withSearchQuery: currentText, page: nextPageNumber, withCompletionHandler: {  [weak self] (serviceResponse) in
            guard let strongSelf = self else { return }
            switch serviceResponse {
            case .success(let localResource):
              strongSelf.nextPageNumber = Utilities.getQueryStringParameter(url: localResource?.next, param: "page")
              completion(localResource?.results ?? []);
            case .failure(_) :
              //Add to Logger Info
              completion([]);
            }
          })
        }
        catch _ {
          //Add to Logger Info
        }
    }
  }
  
  //MARK: - Deinitializer
  
  deinit {
    print("Deinitialized HomeViewModel")
  }
}
