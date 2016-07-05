
import UIKit

// MARK: Instantiation
extension UIView {
  class func instance() -> Self {
    func helper<T: UIView>() -> T {
      return NSBundle.mainBundle().loadNibNamed(T.identifier(), owner: nil, options: nil).first as! T
    }

    return helper()
  }
}

// MARK: Constraints
extension UIView {
  func migrateConstraints(to view: UIView) -> [NSLayoutConstraint] {
    func shouldMigrate(constraint: NSLayoutConstraint) -> Bool {
      return constraint.firstItem as? UIView == self
    }

    func migrate(constraint: NSLayoutConstraint) -> NSLayoutConstraint {
      let second = constraint.secondItem as? UIView == self ? view : constraint.secondItem
      return NSLayoutConstraint(item: view, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: second, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant)
    }

    return constraints.filter { shouldMigrate($0) }.map { migrate($0) }
  }
}
