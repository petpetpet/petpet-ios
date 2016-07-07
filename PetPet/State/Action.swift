
import ReSwift

enum Action: ReSwift.Action {
  case pets(PetsAction)
}

extension StoreType {
  func dispatch(action: Action) -> Any {
    return dispatch(action as ReSwift.Action)
  }
}
