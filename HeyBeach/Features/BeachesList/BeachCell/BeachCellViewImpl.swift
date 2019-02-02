import UIKit

final class BeachCellViewImpl: UICollectionViewCell, BeachCellView {
  
  static let reuseIdentifier = "BeachCellView"

  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  private var presenter: BeachCellPresenter!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    presenter = BeachCellPresenter(with: self)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    presenter.onPrepareForReuse()
  }
  
  func configure(with url: String, name: String) {
    presenter.onConfigure(with: url, name: name)
  }
  
  // MARK: BeachCellView
  
  func configureForLoading() {
    loadingIndicator.startAnimating()
    imageView.isHidden = true
    titleLabel.text = ""
  }
  
  func showImage(_: UIImage, title: String) {
    loadingIndicator.stopAnimating()
    imageView.isHidden = false
    titleLabel.text = title
  }
}
