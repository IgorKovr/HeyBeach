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
    view.configureForUserLoggedIn(repository.hasSavedToken)
    load(page: 0)
  }
  
  func onScrolledCloseToEnd() {
    currentPage += 1
    load(page: currentPage)
  }
  
  func onLoginDialogEndedWith(email: String?, password: String?) {
    guard let email = email, let password = password else {
      return
    }
    
    repository.login(email: email, password: password, onSuccess: { [weak self] in
      self?.view.configureForUserLoggedIn(true)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
  
  func onRegisterDialogEndedWith(email: String?, password: String?) {
    guard let email = email, let password = password else {
      return
    }
    
    repository.register(email: email, password: password, onSuccess: { [weak self] in
      self?.view.configureForUserLoggedIn(true)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
  
  func onLogoutTap() {
    view.configureForUserLoggedIn(false)
    repository.logout(onSuccess: {}) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
  
  private func load(page: UInt) {
    repository.loadImages(at: page, onSuccess: { [weak self] beachesList in
      self?.view.showBeaches(beachesList)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
}
