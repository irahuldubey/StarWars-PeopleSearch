//
//  HomeViewModelTests.swift
//  StarWarsTests
//
//  Created by DUBEY, RAHUL on 4/26/20.
//  Copyright © 2020 SW. All rights reserved.
//

import XCTest

class HomeViewModelTests: XCTestCase {
  
  var homeViewModel: HomeViewModel?
  var mockService: MockSWWebService?
  private var resource: Resource!

  private let people = People.init(name: "NAME",
                                   mass: "MASS",
                                   height: "HEIGHT",
                                   hairColor: "HAIRCOLOR",
                                   skinColor: "SKINCOLOR",
                                   eyeColor: "EYECOLOR",
                                   birthYear: "BIRTHYEAR",
                                   gender: "GENDER",
                                   homeworld: "HOMEWORLD",
                                   created: "CREATED",
                                   edited: "EDITED",
                                   url: "TESTURL")
  
  override func setUp() {
    super.setUp()
    mockService = MockSWWebService()
    homeViewModel = HomeViewModel.init(withAPI: mockService!)
    resource = Resource.init(results: [people], next: "NEXT_URL", previous: "PREVIOUS_URL", count: 100)
  }
  
  override func tearDown() {
    mockService = nil
    homeViewModel = nil
    super.tearDown()
  }

  func testFetchPeopleResultSuccess() {
  
    mockService?.fetchPeopleResourceClosure = { (queryString, page, completion) in
      completion(.success(response: self.resource)
    )}
    
    try? mockService?.fetchPeopleResource(withSearchQuery: "SEARCH_QUERY", page: "PAGE", withCompletionHandler: { (response) in
      switch response {
      case .success(let resource):
        XCTAssertNotNil(resource)
        XCTAssertNotNil(resource?.results)
        if let results = resource?.results, let people = results.first {
          XCTAssert(people.birthYear == "BIRTHYEAR")
          XCTAssert(people.name == "NAME")
          XCTAssert(people.mass == "MASS")
          XCTAssert(people.height == "HEIGHT")
          XCTAssert(people.hairColor == "HAIRCOLOR")
          XCTAssert(people.skinColor == "SKINCOLOR")
          XCTAssert(people.eyeColor == "EYECOLOR")
          XCTAssert(people.gender == "GENDER")
          XCTAssert(people.homeworld == "HOMEWORLD")
          XCTAssert(people.created == "CREATED")
          XCTAssert(people.edited == "EDITED")
          XCTAssert(people.url == "TESTURL")
        }
      case .failure(let error):
        XCTAssertNil(error)
      }
    })
  }
  
  func testFetchPeopleResultFailure() {
    mockService?.fetchPeopleResourceClosure = { (queryString, page, completion) in
      let serviceError = SWServiceError.init(with: 0, errorDescription: "SERVICE_ERROR")
      completion(.failure(error: serviceError)
      )}
    
    try? mockService?.fetchPeopleResource(withSearchQuery: "SEARCH_QUERY", page: "PAGE", withCompletionHandler: { (response) in
      switch response {
      case .success(let resource):
        XCTAssertNotNil(resource)
      case .failure(let error):
        XCTAssert(error?.errorCode == 0)
        XCTAssert(error?.errorDescription == "SERVICE_ERROR")
      }
    })
  }
}
