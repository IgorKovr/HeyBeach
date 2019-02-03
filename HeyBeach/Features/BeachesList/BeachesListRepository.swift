import UIKit

protocol BeachesListRepository {
  
  func loadImages(at page: UInt, onSuccess: @escaping ([BeachModel]) -> Void,
                  onError: @escaping (Error) -> Void)
}

final class BeachesListRepositoryImpl: BeachesListRepository {
  
  private let networkService: NetworkService

  init(with networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
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
}
