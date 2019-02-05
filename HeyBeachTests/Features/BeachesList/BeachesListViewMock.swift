import UIKit
@testable import HeyBeach

final class BeachesListViewMock: BeachesListView {
  
  enum CallMethods {
    case showImagesList
    case showError
    case configureForUserLoggedIn
  }
  
  var callHistory: [CallMethods] = []
  
  func showBeaches(_ list: [BeachModel]) {
    callHistory.append(.showImagesList)
  }
  
  func showError(description: String) {
    callHistory.append(.showError)
  }
  
  func configureForUser(isLoggedIn: Bool) {
    callHistory.append(.configureForUserLoggedIn)
  }
}
