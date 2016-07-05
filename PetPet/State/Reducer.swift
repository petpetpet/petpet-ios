
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
      Pet(owner: "Ty", name: "Potato", image: Image(url: "http://www.awesomeinventions.com/wp-content/uploads/2015/08/husky-pup.jpg", petpets: 30)),
      Pet(owner: "Gigg", name: "Chope", image: Image(url: "http://www.dogtemperament.com/wp-content/uploads/2012/02/bernese-mountain-dog-300x200.jpg", petpets: 25)),
      Pet(owner: "Michael", name: "Luna", image: Image(url: "http://animalia-life.com/data_images/sphynx-cat/sphynx-cat1.jpg", petpets: 20))
    ])
  }
}
