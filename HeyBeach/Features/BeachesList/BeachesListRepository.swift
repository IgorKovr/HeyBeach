import UIKit

protocol BeachesListRepository {
  
  func loadImages(at page: UInt, onSuccess: @escaping ([BeachModel]) -> Void,
                  onError: @escaping (Error) -> Void)
  
  func login(email: String, password: String, onSuccess: @escaping (String) -> Void,
             onError: @escaping (Error) -> Void)
  
  func register(email: String, password: String, onSuccess: @escaping (String) -> Void,
                onError: @escaping (Error) -> Void)
  
  func logout(onSuccess: @escaping () -> Void,
              onError: @escaping (Error) -> Void)
}

final class BeachesListRepositoryImpl: BeachesListRepository {
  
  private let networkService: NetworkService
//  private let storage: Storage

  init(with networkService: NetworkService = NetworkService()) {
//       storage: Storage
    self.networkService = networkService
//    self.storage = storage
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
  
  func login(email: String, password: String, onSuccess: @escaping (String) -> Void,
             onError: @escaping (Error) -> Void) {
    let params = AuthParameters(email: email, password: password)
    networkService.userLogin(with: params) { result in
      switch result {
      case let .success(response):
        onSuccess(response.token)
      case let .failure(networkError):
        onError(Error(networkError))
      }
    }
  }
  
  func register(email: String, password: String, onSuccess: @escaping (String) -> Void,
                onError: @escaping (Error) -> Void) {
    let params = AuthParameters(email: email, password: password)
    networkService.userRegister(with: params) { result in
      switch result {
      case let .success(response):
        onSuccess(response.token)
      case let .failure(networkError):
        onError(Error(networkError))
      }
    }
  }
  
  func logout(onSuccess: @escaping () -> Void,
              onError: @escaping (Error) -> Void) {
    // TODO: Fetch token from storage
    networkService.logout(token: "") { result in
      switch result {
      case .success:
        onSuccess()
      case let .failure(networkError):
        onError(Error(networkError))
      }
    }
  }
}
