import UIKit

final class BeachListViewController: UIViewController, BeachesListView, StoryboardInstantiable, AlertShowable {
  
  private var presenter: BeachesListPresenter!
  private var beachesList = [BeachModel]()
  @IBOutlet weak var collectionView: UICollectionView!
  
  static func instantiate() -> BeachListViewController {
    let controller = instantiateFromStoryboard()
    controller.presenter = BeachesListPresenter(with: controller)
    return controller
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configure()
    presenter.onViewDidLoad()
  }
  
  // MARK: BeachesListView
  
  func showBeaches(_ list: [BeachModel]) {
    beachesList += list
    collectionView.reloadData()
  }
  
  func showError(description: String) {
    showAlert(message: description)
  }
  
  private func configure() {
    collectionView.register(BeachCellViewImpl.nib, forCellWithReuseIdentifier: BeachCellViewImpl.reuseIdentifier)
  }
}

extension BeachListViewController: UICollectionViewDataSource {
  
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
}

