
import Cleanse
import ReSwift

struct StoreModule: Cleanse.Module {
  func configure<B : Binder>(binder binder: B) {
    binder.bind().asSingleton().to {
      Store<State>(reducer: Reducer(), state: nil)
    }
  }
}
