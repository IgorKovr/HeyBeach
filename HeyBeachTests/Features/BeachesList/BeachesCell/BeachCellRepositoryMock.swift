import UIKit
@testable import HeyBeach

final class BeachCellRepositoryMock: BeachCellRepository {
  
  enum CallMethods {
    case stopLoading
    case loadImage
  }
  
  var callHistory: [CallMethods] = []
  var shouldFail: Bool = false
  var mockResponse: UIImage?
  
  func stopLoading() {
    callHistory.append(.stopLoading)
  }
  
  func loadImage(with url: String, completion: (UIImage?) -> Void) {
    if shouldFail {
      completion(nil)
    } else {
      completion(UIImage())
    }
    callHistory.append(.loadImage)
  }
}
