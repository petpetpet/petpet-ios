
import UIKit
import Cleanse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  lazy var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)

  // MARK: UIApplicationDelegate
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let root = try! Graph.Component().build().container()
    window?.rootViewController = root
    window?.makeKeyAndVisible()

    return true
  }
}
