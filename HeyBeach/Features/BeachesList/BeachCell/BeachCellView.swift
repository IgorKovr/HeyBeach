import UIKit

protocol BeachCellView: class {
  
  func configureForLoading()
  func showImage(_: UIImage?, title: String)
}
