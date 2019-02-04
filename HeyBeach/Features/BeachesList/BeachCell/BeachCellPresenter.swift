import Foundation

final class BeachCellPresenter {
  
  unowned private let view: BeachCellView
  private let repository: BeachCellRepository
  
  init(with view: BeachCellView,
       repository: BeachCellRepository = BeachCellRepositoryImpl()) {
    self.view = view
    self.repository = repository
  }
  
  func onPrepareForReuse() {
    repository.stopLoading()
  }
  
  func onConfigure(url: String, title: String, cache: ImageCache) {
    if let image = repository.fetch(image: url, from: cache) {
      view.showImage(image, title: title)
    } else {
      view.configureForLoading()
      repository.loadImage(with: url, cache: cache) { [weak self] image in
        self?.view.showImage(image, title: title)
      }
    }
  }
}
