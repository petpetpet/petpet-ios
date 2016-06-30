
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
      return constraint.firstItem as? UIView == self && constraint.secondItem == nil
    }

    func migrate(constraint: NSLayoutConstraint) -> NSLayoutConstraint {
      return NSLayoutConstraint(item: view, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant)
    }

    return constraints.filter { shouldMigrate($0) }.map { migrate($0) }
  }
}
