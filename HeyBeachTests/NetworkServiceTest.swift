import XCTest
@testable import HeyBeach

class NetworkServiceTest: XCTestCase {
  
  let requestTimeout = 0.0
  
  private var service: NetworkService!
  private var router: NetworkRouterMock!
  
  override func setUp() {
    super.setUp()
    
    router = NetworkRouterMock(jsonFile: "ImageListResponse")
    service = NetworkService(networkRouter: router)
  }
  
  func testLoginSuccess() {
    router.shouldReturnBadResponse = true
    let expectation = XCTestExpectation(description: "it should fetch token on login request")
    
    let parameters = AuthParameters(email: "", password: "")
    
    service.userLogin(with: parameters) { result in
      switch result {
      case .success(_):
        XCTFail()
      case let .failure(error):
        XCTAssertEqual(error, .api)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: requestTimeout)
  }

  func testRegisterApiError() {
    router.shouldReturnBadResponse = true
    let expectation = XCTestExpectation(description: "it should return api error on register request")

    let parameters = AuthParameters(email: "", password: "")
    
    service.userRegister(with: parameters) { result in
      switch result {
      case .success(_):
        XCTFail()
      case let .failure(error):
        XCTAssertEqual(error, .api)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: requestTimeout)
  }
  
  func testRegisterSuccess() {
    let expectation = XCTestExpectation(description: "it should fetch token on register request")
    let parameters = AuthParameters(email: "test", password: "test")
    router.mockHeader = ["x-auth" : "token"]
    
    service.userRegister(with: parameters) { result in
      switch result {
      case let .success(reponse):
        XCTAssertEqual(reponse.token, "token")
      case let .failure(error):
        XCTFail(error.localizedDescription)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: requestTimeout)
  }

  func testFetchImagesSuccess() {
    let expectation = XCTestExpectation(description: "it should fetch list of images")

    service.fetchImagesList(page: 0) { result in
      switch result {
      case let .success(images):
        XCTAssertTrue(images.count > 0)
      case let .failure(error):
        XCTFail(error.localizedDescription)
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: requestTimeout)
  }
  
  func testFetchImageDataSuccess() {
    router.responseData = Data()
    let expectation = XCTestExpectation(description: "it should fetch image data")
    let url = "images/b09a4caf-014c-4003-85a4-bf520206ff33.png"
    
    service.downloadImage(url: url) { result in
      switch result {
      case let .success(data):
        XCTAssertNotNil(data)
      case let .failure(error):
        XCTFail(error.localizedDescription)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: requestTimeout)
  }
}
