import Foundation
@testable import HeyBeach

final class NetworkRouterMock: NetworkRouter {
  
  var jsonData: Data?
  var mockHeader: [String : String]?
  var shouldReturnBadResponse: Bool = false
  
  init(jsonFile: String?, networkError: NetworkError? = nil) {
    let testBundle = Bundle(for: type(of: self))
    if let url = testBundle.url(forResource: jsonFile, withExtension: "json") {
      self.jsonData = try? Data(contentsOf:url)
    } else {
      self.jsonData = nil
    }
  }
  
  func request(_ route: Endpoint, parameters: HTTPParametersConvertable?,
               completion: @escaping NetworkRouterCompletion) {
    let response = HTTPURLResponse(url: route.url,
                                   statusCode: shouldReturnBadResponse ? 418 : 200,
                                   httpVersion: "",
                                   headerFields: mockHeader)
    completion(jsonData, response, nil)
  }
}
