import UIKit

protocol BeachesListRepository {
  
  func loadImages(at page: UInt, onSuccess: @escaping ([BeachModel]) -> Void,
                  onError: @escaping (Error) -> Void)
  
  func login(email: String, password: String, onSuccess: @escaping () -> Void,
             onError: @escaping (Error) -> Void)
  
  func register(email: String, password: String, onSuccess: @escaping () -> Void,
                onError: @escaping (Error) -> Void)
  
  func logout(onSuccess: @escaping () -> Void,
              onError: @escaping (Error) -> Void)

  var hasSavedToken: Bool { get }
}

final class BeachesListRepositoryImpl: BeachesListRepository {

  var hasSavedToken: Bool {
    return retrieveToken() != nil
  }
  
  private let networkService: NetworkService
  private let storage: Storage

  init(with networkService: NetworkService = NetworkService(),
       storage: Storage = KeychainStorage()) {
    self.networkService = networkService
    self.storage = storage
  }

  func loadImages(at page: UInt, onSuccess: @escaping ([BeachModel]) -> Void, onError: @escaping (Error) -> Void) {
    networkService.fetchImagesList(page: page) { result in
      switch result {
      case let .success(response):
        let beachesList = response.map { BeachModel($0) }
        onSuccess(beachesList)
      case let .failure(networkError):
        onError(Error(networkError))
      }
    }
  }
  
  func login(email: String, password: String, onSuccess: @escaping () -> Void,
             onError: @escaping (Error) -> Void) {
    let params = AuthParameters(email: email, password: password)
    networkService.userLogin(with: params) { [weak self] result in
      switch result {
      case let .success(response):
        self?.saveToken(response.token)
        onSuccess()
      case let .failure(networkError):
        onError(Error(networkError))
      }
    }
  }
  
  func register(email: String, password: String, onSuccess: @escaping () -> Void,
                onError: @escaping (Error) -> Void) {
    let params = AuthParameters(email: email, password: password)
    networkService.userRegister(with: params) { [weak self] result in
      switch result {
      case let .success(response):
        self?.saveToken(response.token)
        onSuccess()
      case let .failure(networkError):
        onError(Error(networkError))
      }
    }
  }
  
  func logout(onSuccess: @escaping () -> Void,
              onError: @escaping (Error) -> Void) {
    guard let token = retrieveToken() else {
      assertionFailure("couldn't retreive token")
      return
    }

    removeUserData()
    networkService.logout(token: token) { result in
      switch result {
      case .success:
        onSuccess()
      case let .failure(networkError):
        onError(Error(networkError))
      }
    }
  }

  private func retrieveToken() -> String? {
    return storage.stringValue(for: .authToken)
  }

  private func saveToken(_ token: String) {
    storage.set(string: token, for: .authToken)
  }

  private func removeUserData() {
    storage.flush()
  }
}
