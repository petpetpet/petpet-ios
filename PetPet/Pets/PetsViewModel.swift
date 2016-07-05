
import Cleanse
import ReSwift
import RxSwift

struct PetsViewModel {
  private let store: Store<State>

  // MARK: Data Sources
  func pets() -> Observable<[State.Pet]> {
    return store.changes().map { $0.pets }
  }
}

// MARK: Module
extension PetsViewModel {
  struct Module: Cleanse.Module {
    func configure<B: Binder>(binder binder: B) {
      binder.bind().to(factory: PetsViewModel.init)
    }
  }
}
