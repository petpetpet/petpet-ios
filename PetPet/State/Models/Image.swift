
extension State {
  struct Image {
    let url: String
    var petpets: Int
  }
}

extension State.Image: Defaultable {
  static func fallback() -> State.Image {
    return State.Image(url: zero(), petpets: zero())
  }
}
