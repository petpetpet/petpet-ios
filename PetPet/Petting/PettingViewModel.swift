
import Cleanse

struct PettingViewModel {
}

extension PettingViewModel {
  struct Module: Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {
      binder.bind().to(factory: PettingViewModel.init)
    }
  }
}
