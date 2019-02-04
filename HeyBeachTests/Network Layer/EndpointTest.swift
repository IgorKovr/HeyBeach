import XCTest
@testable import HeyBeach

final class EndpointTest: XCTestCase {
  
  private var endpoint: Endpoint!
  
  override func setUp() {
    super.setUp()
    
    endpoint = .beaches(page: 999)
  }

  func testBeachesURL() {
    XCTAssertEqual(endpoint.url.absoluteString,
                   "http://techtest.lab1886.io:3000/beaches?page=999")
  }
}
