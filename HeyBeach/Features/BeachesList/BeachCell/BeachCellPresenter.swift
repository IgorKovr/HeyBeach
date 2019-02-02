import Foundation

final class BeachCellPresenter {
  
  unowned private let view: BeachCellView
  private let repository: BeachCellRepository
  
  init(with view: BeachCellView, repository: BeachCellRepository = BeachCellRepositoryImpl()) {
    self.view = view
    self.repository = repository
  }
  
  func onPrepareForReuse() {
    repository.stopLoading()
    view.configureForLoading()
  }
  
  func onConfigure(with url: String, name: String) {
    repository.loadImage(with: url) { [weak self] image in
      guard let image = image else { return }
      
      self?.view.showImage(image, title: name)
    }
  }
}
