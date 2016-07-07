
import ReSwift

struct State: StateType {
  var pets: [Pet]
  var selectedIndex: Int?
}

extension State {
  var selectedPet: Pet? {
    return selectedIndex.map { pets[$0] }
  }
}
