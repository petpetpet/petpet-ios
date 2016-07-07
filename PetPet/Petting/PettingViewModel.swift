
import Cleanse
import ReSwift
import RxSwift

struct PettingViewModel {
  private let store: Store<State>

  func pet() -> Observable<State.Pet> {
    return store.changes()
      .take(1)
      .map { coalesce($0.selectedPet) }
  }
}

extension PettingViewModel {
  struct Module: Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {
      binder.bind().to(factory: PettingViewModel.init)
    }
  }
}
