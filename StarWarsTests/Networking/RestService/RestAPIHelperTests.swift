//
//  RestAPIHelperTests.swift
//  StarWarsTests
//
//  Created by DUBEY, RAHUL on 4/26/20.
//  Copyright © 2020 SW. All rights reserved.
//

import XCTest

class RestAPIHelperTests: XCTestCase {
    
  override func setUpWithError() throws { }
  
  override func tearDownWithError() throws { }
  
  func testSearchURLStringPath() throws {
    let searchURL = RestAPIHelper.searchURL(with: .people, andQueryString: "QUERY", page: "1")
    XCTAssert(searchURL == "https://swapi.dev/api/people/?search=QUERY&page=1")
  }
  
  func testCharacterImageAPI() throws {
    let imageURl = RestAPIHelper.getCharacterImageAPI(with: "100")
    XCTAssert(imageURl == "https://cdn.rawgit.com/akabab/starwars-api/0.2.1/api/id/100.json")
  }
  
  func testURLRequest() throws {
    let testURL = "https://www.google.com"
    let urlRequest = RestAPIHelper.getURLRequest(with: URL(string: testURL)!)
    XCTAssert(urlRequest.url?.absoluteString == testURL)
    XCTAssert(urlRequest.timeoutInterval == 10.0)
    XCTAssert(urlRequest.httpMethod == "GET")
    XCTAssertTrue(urlRequest.httpShouldHandleCookies)
    XCTAssertFalse(urlRequest.httpShouldUsePipelining)
  }
}
