
import Cleanse
import ReSwift
import RxSwift

struct PetsViewModel {
  private let store:  Store<State>
  private let routes: Provider<PettingRoute>

  // MARK: Data Sources
  func pets() -> Observable<[State.Pet]> {
    return store.changes().map { $0.pets }
  }

  // MARK: Actions
  func selectOption(at index: Int) -> RouteType {
    store.dispatch(.pets(.select(pet: index)))
    return routes.get()
  }
}

// MARK: Module
extension PetsViewModel {
  struct Module: Cleanse.Module {
    func configure<B: Binder>(binder binder: B) {
      binder.install(module: PettingRoute.Module())
      binder.bind().to(factory: PetsViewModel.init)
    }
  }
}
