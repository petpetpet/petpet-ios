
import UIKit

class PetCell: Cell, Replaceable {
}

// MARK: Adaptable
extension PetCell: Adaptable {
  func bind(model: State.Pet) {
  }

  static func estimatedSize(given container: CGSize) -> CGSize {
    return CGSize(width: container.width, height: 44.0)
  }
}
