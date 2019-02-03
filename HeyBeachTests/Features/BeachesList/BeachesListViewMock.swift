import UIKit
@testable import HeyBeach

final class BeachesListViewMock: BeachesListView {
  
  enum CallMethods {
    case showImagesList
    case showError
  }
  
  var callHistory: [CallMethods] = []
  
  func showBeaches(_ list: [BeachModel]) {
    callHistory.append(.showImagesList)
  }
  
  func showError(description: String) {
    callHistory.append(.showError)
  }
}
