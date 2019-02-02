import XCTest
@testable import HeyBeach

class EndpointTest: XCTestCase {
  
  private var endpoint: Endpoint!
  
  override func setUp() {
    super.setUp()
    
    endpoint = .beaches(page: 999)
  }

  func testArtworkListURL() {
    XCTAssertEqual(endpoint.url.absoluteString,
                   "http://techtest.lab1886.io:3000/beaches?page=999")
  }
}
