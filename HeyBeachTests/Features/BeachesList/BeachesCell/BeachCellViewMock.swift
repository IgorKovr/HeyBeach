import UIKit
@testable import HeyBeach

final class BeachCellViewMock: BeachCellView {
  
  enum CallMethods {
    case configureForLoading
    case showImage
  }
  
  var callHistory: [CallMethods] = []

  func configureForLoading() {
    callHistory.append(.configureForLoading)
  }
  
  func showImage(_: UIImage, title: String) {
    callHistory.append(.showImage)
  }
}
