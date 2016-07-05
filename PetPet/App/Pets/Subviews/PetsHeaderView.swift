
import UIKit

class PetsHeaderView: ReusableView, Replaceable {
}

// MARK: Adaptable
extension PetsHeaderView: Adaptable {
  func bind(model: State.Pet) {
  }

  static func estimatedSize(given container: CGSize) -> CGSize {
    return CGSize(width: container.width, height: 100.0)
  }
}
