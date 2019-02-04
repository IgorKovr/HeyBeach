import UIKit

final class BeachListViewController: UIViewController, BeachesListView, StoryboardInstantiable, AlertShowable {

  private let itemsLeftToLoadNewPage = 5
  private var presenter: BeachesListPresenter!
  private var beachesList = [BeachModel]()
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var navigationBarItem: UINavigationItem!
  
  static func instantiate() -> BeachListViewController {
    let controller = instantiateFromStoryboard()
    controller.presenter = BeachesListPresenter(with: controller)
    return controller
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    presenter.onViewDidLoad()
  }
  
  // MARK: BeachesListView
  
  func showBeaches(_ list: [BeachModel]) {
    guard !list.isEmpty else { return }

    let oldItemsCount = beachesList.count
    beachesList += list
    updateCollectionViewForNewItems(oldItemsCount: oldItemsCount)
  }
  
  func showError(description: String) {
    showAlert(message: description)
  }
  
  func configureForUserLoggedIn(_ loggedIn: Bool) {
    if loggedIn {
      createLogoutElements()
    } else {
      createLoginElements()
    }
  }
  
  private func configureCollectionView() {
    collectionView.register(BeachCellViewImpl.nib, forCellWithReuseIdentifier: BeachCellViewImpl.reuseIdentifier)
  }

  private func updateCollectionViewForNewItems(oldItemsCount: Int) {
    collectionView.performBatchUpdates({
      let insertIndexPaths = Array(oldItemsCount..<beachesList.count).map {
        IndexPath(item: $0, section: 0)
      }
      collectionView.insertItems(at: insertIndexPaths)
    }, completion: nil)
  }
}

extension BeachListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return beachesList.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeachCellViewImpl.reuseIdentifier,
                                                  for: indexPath) as! BeachCellViewImpl
    let beachModel = beachesList[indexPath.item]
    cell.configure(url: beachModel.url, title: beachModel.title)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if (indexPath.row >= beachesList.count - 1 - itemsLeftToLoadNewPage) {
      presenter.onScrolledCloseToEnd()
    }
  }
}

// MARK: Authentication Elements

private extension BeachListViewController {
  
  @objc func registerTap() {
    showAuthAlert(title: "Register") { (email, password) in
      self.presenter.onRegisterDialogEndedWith(email: email, password: password)
    }
  }
  
  @objc func loginTap() {
    showAuthAlert(title: "Login") { (email, password) in
      self.presenter.onLoginDialogEndedWith(email: email, password: password)
    }
  }
  
  @objc func logoutTap() {
    presenter.onLogoutTap()
  }
  
  private func createLoginElements() {
    navigationBarItem.rightBarButtonItem = UIBarButtonItem.init(
      title: "Register",
      style: .plain,
      target: self,
      action: #selector(registerTap))

    navigationBarItem.leftBarButtonItem = UIBarButtonItem.init(
      title: "Login",
      style: .plain,
      target: self,
      action: #selector(loginTap)
    )
  }

  private func createLogoutElements() {
    navigationBarItem.leftBarButtonItem = nil
    navigationBarItem.rightBarButtonItem = UIBarButtonItem.init(
      title: "Logout",
      style: .plain,
      target: self,
      action: #selector(logoutTap)
    )
  }
}

private extension BeachListViewController {
  
  func showAuthAlert(title: String, onActionTap: @escaping (String?, String?) -> Void) {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let authAction = UIAlertAction(
      title: title,
      style: .default,
      handler: { _ in onActionTap(alert.textFields?[0].text, alert.textFields?[1].text) }
    )
    alert.addAction(authAction)
    alert.addTextField("email")
    alert.addTextField("password")
    alert.addCancelAction()
    self.present(alert, animated: true, completion: nil)
  }
}
