
import UIKit
import Cleanse

struct PetsRoute: RouteType {
  private let _view:  PetsViewController

  func view() -> UIViewController {
    return _view
  }
}

extension PetsRoute {
  struct Module: Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {
      binder
        .install(module: PetsViewModel.Module())
        .install(module: PetsViewController.Module())

      binder.bind().to(factory: PetsRoute.init)
    }
  }
}
