
import Cleanse

class PetsViewController: ViewController {
}

// MARK: Module
extension PetsViewController {
  struct Module: Cleanse.Module {
    func configure<B: Binder>(binder binder: B) {
      binder.bind().to(factory: PetsViewController.instance)
    }
  }
}
