import UIKit
@testable import HeyBeach

final class BeachesListRepositoryMock: BeachesListRepository {
  
  enum CallMethods {
    case loadImages
  }
  
  var callHistory: [CallMethods] = []
  var shouldFail: Bool = false
  var mockResponse: [BeachModel]?
  
  func loadImages(at page: UInt, onSuccess: @escaping ([BeachModel]) -> Void,
                  onError: @escaping (HeyBeach.Error) -> Void) {
    if shouldFail {
      onError(HeyBeach.Error(NetworkError.api))
    } else {
      onSuccess(mockResponse ?? [])
    }
    callHistory.append(.loadImages)
  }
}
