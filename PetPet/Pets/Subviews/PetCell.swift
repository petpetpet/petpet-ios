
import UIKit

class PetCell: Cell, Replaceable {
  // MARK: Outlets
  @IBOutlet weak var picView:    PetPicView!
  @IBOutlet weak var petLabel:   UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
}

// MARK: Adaptable
extension PetCell: Adaptable {
  func bind(model: State.Pet) {
    petLabel.text   = model.name
    ownerLabel.text = model.owner
    countLabel.text = "\(model.image.petpets)"

    picView.load(image: model.image)
  }

  static func estimatedSize(given container: CGSize) -> CGSize {
    return CGSize(width: container.width, height: 200.0)
  }
}
