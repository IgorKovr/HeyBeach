import UIKit
@testable import HeyBeach

final class BeachesListRepositoryMock: BeachesListRepository {
  
  enum CallMethods {
    case loadImages
    case login
    case register
    case logout
  }

  var hasSavedToken = false

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
  
  func login(email: String, password: String, onSuccess: @escaping () -> Void,
             onError: @escaping (HeyBeach.Error) -> Void) {
    if shouldFail {
      onError(HeyBeach.Error(NetworkError.api))
    } else {
      onSuccess()
    }
    callHistory.append(.login)
  }
  
  func register(email: String, password: String, onSuccess: @escaping () -> Void,
                onError: @escaping (HeyBeach.Error) -> Void) {
    if shouldFail {
      onError(HeyBeach.Error(NetworkError.api))
    } else {
      onSuccess()
    }
    callHistory.append(.register)
  }
  
  func logout(onSuccess: @escaping () -> Void,
              onError: @escaping (HeyBeach.Error) -> Void) {
    if shouldFail {
      onError(HeyBeach.Error(NetworkError.api))
    } else {
      onSuccess()
    }
    callHistory.append(.logout)
  }
}
