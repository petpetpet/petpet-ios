
import ReSwift

struct State: StateType {
  var pets: [Pet]
}

extension State {
  struct Pet {
    let owner: String
    let name:  String
    var image: Image
  }

  struct Image {
    let url: String
    var petpets: Int
  }
}
