import Foundation

final class BeachesListPresenter {
  
  unowned private let view: BeachesListView
  private let repository: BeachesListRepository
  private var currentPage: UInt = 0
  private var isUserLoggedIn = false
  
  init(with view: BeachesListView, repository: BeachesListRepository = BeachesListRepositoryImpl()) {
    self.view = view
    self.repository = repository
  }
  
  func onViewDidLoad() {
    view.configureForUserLoggedIn(isUserLoggedIn)
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
    
    repository.login(email: email, password: password, onSuccess: { [weak self] token in
      self?.saveToken(token)
      self?.view.configureForUserLoggedIn(true)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
  
  func onRegisterDialogEndedWith(email: String?, password: String?) {
    guard let email = email, let password = password else {
      return
    }
    
    repository.register(email: email, password: password, onSuccess: { [weak self] token in
      self?.saveToken(token)
      self?.view.configureForUserLoggedIn(true)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
  
  func onLogoutTap() {
    repository.logout(onSuccess: { [weak self] in
      self?.removeToken()
      self?.view.configureForUserLoggedIn(false)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
  
  private func load(page: UInt) {
    repository.loadImages(at: 0, onSuccess: { [weak self] beachesList in
      self?.view.showBeaches(beachesList)
    }) { [weak self] error in
      self?.view.showError(description: error.localizedDescription)
    }
  }
  
  private func saveToken(_ token: String) {
    // TODO: Save Token
  }
  
  private func removeToken() {
    // TODO: Remove Token
  }
}
