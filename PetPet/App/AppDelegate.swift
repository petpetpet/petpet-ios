
import UIKit
import Cleanse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  lazy var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)

  // MARK: UIApplicationDelegate
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    try! Component().build().injectProperties(into: self)
    window?.makeKeyAndVisible()
    return true
  }

  // MARK: Injection
  private func inject(root: PetsViewController) {
    window?.rootViewController = root
  }
}

// MARK: Component
extension AppDelegate {
  struct Component: Cleanse.Component {
    typealias Root = PropertyInjector<AppDelegate>

    func configure<B: Binder>(binder binder: B) {
      binder.install(module: PetsViewController.Module())
      binder.bindPropertyInjectionOf().to(injector: inject)
    }
  }
}
