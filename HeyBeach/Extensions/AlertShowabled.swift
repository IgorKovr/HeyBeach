import UIKit

protocol AlertShowable {
  
  func showAlert(title: String?, message: String?)
}

extension AlertShowable where Self: UIViewController {
  
  func showAlert(title: String? = nil, message: String? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    self.present(alert, animated: true, completion: nil)
  }
}
