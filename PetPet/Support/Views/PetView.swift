
import UIKit

class PetView: View, Replaceable {
  // MARK: Outlets
  @IBOutlet weak var picView:    PetPicView!
  @IBOutlet weak var petLabel:   UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
}

// MARK: Adaptable
extension PetView: Bindable {
  func bind(model: State.Pet) {
    petLabel.text   = model.name
    ownerLabel.text = model.owner
    countLabel.text = "\(model.image.petpets)"
    picView.load(image: model.image)
  }
}
