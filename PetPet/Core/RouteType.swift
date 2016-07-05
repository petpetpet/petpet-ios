
import UIKit

// MARK: RouteType
protocol RouteType {
  func view() -> UIViewController
  func transition() -> RouteTransition
}

extension RouteType {
  func transition() -> RouteTransition {
    return .stack
  }
}

// MARK: Transition
enum RouteTransition {
  case stack
}

// MARK: Resolver
extension UIViewController {
  func resolve(route: RouteType, animated: Bool = true) {
    switch route.transition() {
      case .stack: resolveStack(route, animated: animated)
    }
  }

  private func resolveStack(route: RouteType, animated: Bool) {
    guard let
      navigation = navigationController else { return }

    if animated {
      navigation.pushViewController(route.view(), animated: animated)
    } else {
      navigation.viewControllers.append(route.view())
    }
  }
}
