import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    createAndPresentWindow()
    return true
  }
  
  private func createAndPresentWindow() {
    let rootViewController = BeachListViewController.instantiate()
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    self.window = window
  }
}
