import Foundation

final class BeachesListPresenter {
  
  unowned private let view: BeachesListView
  private let repository: BeachesListRepository
  private var currentPage: UInt = 0
  
  init(with view: BeachesListView, repository: BeachesListRepository = BeachesListRepositoryImpl()) {
    self.view = view
    self.repository = repository
  }
  
  func onViewDidLoad() {
    load(page: 0)
  }
  
  func onScrolledCloseToEnd() {
    currentPage += 1
    load(page: currentPage)
  }
  
  private func load(page: UInt) {
    repository.loadImages(at: 0, onSuccess: { [weak self] beachesList in
      self?.view.showBeaches(beachesList)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
}
