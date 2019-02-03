import UIKit

protocol StoryboardInstantiable: class {
  
  static func instantiateFromStoryboard() -> Self
}

extension StoryboardInstantiable where Self: UIViewController {
  
  static func instantiateFromStoryboard() -> Self {
    let storyboard = UIStoryboard(name: "\(self)", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "\(self)") as! Self
  }
}

