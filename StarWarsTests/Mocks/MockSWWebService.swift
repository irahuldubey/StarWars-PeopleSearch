//
//  MockSWService.swift
//  StarWarsTests
//
//  Created by DUBEY, RAHUL on 4/26/20.
//  Copyright © 2020 SW. All rights reserved.
//

import Foundation

/// Class Description: MOCK class for the webservice calls from the client, wrapped in a protocol.
final class MockSWWebService: SWWebServiceAPI {

  var fetchPeopleResourceClosure: (( _ queryString: String, _ page: String, _ completion: (SWServiceResponse) -> ()) -> ())?
  
  func fetchPeopleResource(withSearchQuery queryString: String, page: String, withCompletionHandler completion: @escaping (SWServiceResponse) -> ()) throws {
    fetchPeopleResourceClosure?(queryString, page, completion)
  }
  
  var fetchImageClosure: (( _ id: String, _ completion: (Data?) -> ()) -> ())?

  func fetchImage(with id: String, completionHandler completion: @escaping (Data?) -> ()) throws {
    fetchImageClosure?(id, completion)
  }
}
