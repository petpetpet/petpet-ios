
import Cleanse

class PettingViewController: ViewController {
  // MARK: View Lifecycle
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBarHidden = true
  }
}

// MARK: Module
extension PettingViewController {
  struct Module: Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {
      binder.bind().to(factory: PettingViewController.instance)
    }
  }
}
