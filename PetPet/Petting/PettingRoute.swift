
import UIKit
import Cleanse

struct PettingRoute: RouteType {
  private let _view: PettingViewController

  func view() -> UIViewController {
    return _view
  }
}

extension PettingRoute {
  struct Module: Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {
      binder
        .install(module: PettingViewModel.Module())
        .install(module: PettingViewController.Module())

      binder.bind().to(factory: PettingRoute.init)
    }
  }
}
