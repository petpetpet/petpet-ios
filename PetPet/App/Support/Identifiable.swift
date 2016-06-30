
import UIKit

protocol Identifiable {
  static func identifier() -> String
}

extension UIView: Identifiable {
  static func identifier() -> String {
    return name(from: self)
  }
}

extension UIViewController: Identifiable {
  static func identifier() -> String {
    return name(from: self)
  }
}
