
enum PetsAction {
  case select(pet: Int)
}

extension PetsAction: ActionType {
  func reduce(state: State) -> State {
    switch self {
      case .select(let index): return reduce(selection: index, given: state)
    }
  }
}

// MARK: Selection
extension PetsAction {
  func reduce(selection index: Int, given state: State) -> State {
    var state = state
    state.selectedIndex = index
    return state
  }
}
