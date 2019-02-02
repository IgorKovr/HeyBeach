import UIKit

protocol BeachCellRepository {
 
  func stopLoading()
  func loadImage(with url: String, completion: @escaping (UIImage?) -> Void)
}

final class BeachCellRepositoryImpl: BeachCellRepository {
  
  private let networkService: NetworkService
  
  init(with networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  func stopLoading() {
    networkService.cancelRequest()
  }
  
  func loadImage(with url: String, completion: @escaping (UIImage?) -> Void) {
    networkService.downloadImage(url: url) { result in
      switch result {
      case let .success(data):
        completion(UIImage(data: data))
      case .failure: completion(nil)
      }
    }
  }
}
