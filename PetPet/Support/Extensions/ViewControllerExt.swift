
import UIKit

extension UIViewController {
  static func instance() -> Self {
    func helper<T: UIViewController>() -> T {
      return storyboard().instantiateViewControllerWithIdentifier(T.identifier()) as! T
    }

    return helper()
  }

  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: storyboardName(), bundle: nil)
  }

  static func storyboardName() -> String {
    return identifier().stringByReplacingOccurrencesOfString("ViewController", withString: "")
  }
}
