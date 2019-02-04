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
  var mockCachedImage: UIImage?
  
  func stopLoading() {
    callHistory.append(.stopLoading)
  }

  func fetch(image url: String, from cache: ImageCache) -> UIImage? {
    return mockCachedImage
  }
  
  func loadImage(with url: String, cache: ImageCache,
                 completion: (UIImage?) -> Void) {
    if shouldFail {
      completion(nil)
    } else {
      completion(UIImage())
    }
    callHistory.append(.loadImage)
  }
}
