
import UIKit

protocol Replaceable {
  func isPlaceholder() -> Bool
  func replacement() -> AnyObject?
}

extension Replaceable where Self: UIView {
  func replacement() -> AnyObject? {
    let replacement = self.dynamicType.instance()
    replacement.addConstraints(migrateConstraints(to: replacement))
    replacement.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
    return replacement
  }

  func isPlaceholder() -> Bool {
    return subviews.count == 0
  }
}

extension Replaceable where Self: Cell {
  func isPlaceholder() -> Bool {
    return contentView.subviews.count == 0
  }
}

// MARK: Helpers
func replace(candidate: AnyObject) -> AnyObject? {
  if let instance = candidate as? Replaceable {
    if instance.isPlaceholder() {
      return instance.replacement()
    }
  }

  return nil
}
