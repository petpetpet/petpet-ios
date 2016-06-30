
import ReSwift

struct Reducer: ReSwift.Reducer {
  func handleAction(action: Action, state: State?) -> State {
    guard let state = state else { return State.initial() }
    return state
  }
}

private extension State {
  static func initial() -> State {
    return State(pets: [
      Pet(owner: "Ty", name: "Potato", image: Image(url: "whatevs", petpets: 30)),
      Pet(owner: "Gigg", name: "Chope", image: Image(url: "something", petpets: 25)),
      Pet(owner: "Michael", name: "Luna", image: Image(url: "that", petpets: 20))
    ])
  }
}
