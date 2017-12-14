import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    let viewController = UIViewController()
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    return true
  }

}

