
import UIKit
import Cleanse

struct Graph {
  private let _view: Provider<PetsRoute>

  func container() -> UINavigationController {
    return UINavigationController(rootViewController: _view.get().view())
  }
}

// MARK: Component
extension Graph {
  struct Component: Cleanse.Component {
    typealias Root = Graph

    func configure<B: Binder>(binder binder: B) {
      binder
        .install(module: StoreModule())
        .install(module: PetsRoute.Module())

      binder.bind().to(factory: Graph.init)
    }
  }
}
