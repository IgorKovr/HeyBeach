import UIKit

protocol AlertShowable {
  
  func showAlert(title: String?, message: String?)
}

extension AlertShowable where Self: UIViewController {
  
  func showAlert(title: String? = nil, message: String? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addCancelAction()
    self.present(alert, animated: true, completion: nil)
  }
}

extension UIAlertController {
  
  func addCancelAction() {
    self.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
  }
  
  func addTextField(_ name: String) {
    self.addTextField { (textField: UITextField) in
      textField.placeholder = name
      textField.isSecureTextEntry = true
    }
  }
}
