
import UIKit

class PetCell: Cell, Replaceable {
  // MARK: Outlets
  @IBOutlet weak var petView: PetView!
}

// MARK: Adaptable
extension PetCell: Adaptable {
  func bind(model: State.Pet) {
    petView.bind(model)
  }

  static func estimatedSize(given container: CGSize) -> CGSize {
    return CGSize(width: container.width, height: 200.0)
  }
}
