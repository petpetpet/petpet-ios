
import UIKit

protocol Bindable {
  associatedtype Model
  func bind(model: Model)
}

extension Bindable {
  func bind(optional model: Model?) -> Self {
    guard let model = model else { return self }
    return bind(model)
  }

  func bind(model: Model) -> Self {
    bind(model)
    return self
  }
}

extension Bindable where Self: UIViewController {
  static func create(with model: Model) -> Self {
    return instance().bind(model)
  }
}

extension Bindable where Self: UIView {
  static func create(with model: Model) -> Self {
    return instance().bind(model)
  }
}
