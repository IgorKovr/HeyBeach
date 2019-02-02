import Foundation
@testable import HeyBeach

final class NetworkRouterMock: NetworkRouter {
  
  var responseData: Data?
  var mockHeader: [String : String]?
  var shouldReturnBadResponse: Bool = false
  var cancelRequestWasCalled: Bool = false
  
  private let goodResponseCode = 200
  private let badResponseCode = 418
  
  init(jsonFile: String?, networkError: NetworkError? = nil) {
    let testBundle = Bundle(for: type(of: self))
    if let url = testBundle.url(forResource: jsonFile, withExtension: "json") {
      self.responseData = try? Data(contentsOf:url)
    } else {
      self.responseData = nil
    }
  }
  
  func cancelRequest() {
    cancelRequestWasCalled = true
  }
  
  func request(_ route: Endpoint, parameters: HTTPParametersConvertable?,
               completion: @escaping NetworkRouterCompletion) {
    let response = HTTPURLResponse(url: route.url,
                                   statusCode: shouldReturnBadResponse ? badResponseCode : goodResponseCode,
                                   httpVersion: "",
                                   headerFields: mockHeader)
    completion(responseData, response, nil)
  }
}
