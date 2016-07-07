
extension State {
  struct Pet {
    let owner: String
    let name:  String
    var image: Image
  }
}

// MARK: Defaultable
extension State.Pet: Defaultable {
  static func fallback() -> State.Pet {
    return State.Pet(owner: zero(), name: zero(), image: zero())
  }
}
