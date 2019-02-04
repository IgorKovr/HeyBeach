import UIKit

final class BeachCellViewImpl: UICollectionViewCell, BeachCellView {
  
  static let reuseIdentifier = "BeachCellView"
  static var nib: UINib {
    return UINib(nibName: "\(self)", bundle:nil)
  }

  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  private var presenter: BeachCellPresenter!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    presenter.onPrepareForReuse()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    presenter = BeachCellPresenter(with: self)
  }
  
  func configure(url: String, title: String, cache: ImageCache) {
    
    presenter.onConfigure(url: url, title: title, cache: cache)
  }
  
  // MARK: BeachCellView
  
  func configureForLoading() {
    loadingIndicator.startAnimating()
    imageView.isHidden = true
    titleLabel.text = ""
  }
  
  func showImage(_ image: UIImage?, title: String) {
    loadingIndicator.stopAnimating()
    imageView.isHidden = false
    imageView.image = image
    titleLabel.text = title
  }
}
