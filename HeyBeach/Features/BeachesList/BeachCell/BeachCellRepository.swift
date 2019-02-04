import UIKit

typealias ImageCache = NSCache<AnyObject, UIImage>

protocol BeachCellRepository {
 
  func stopLoading()
  func loadImage(with url: String, cache: ImageCache,
                 completion: @escaping (UIImage?) -> Void)
  func fetch(image url: String, from cache: ImageCache) -> UIImage?
}

final class BeachCellRepositoryImpl: BeachCellRepository {
  
  private let networkService: NetworkService
  
  init(with networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  func stopLoading() {
    networkService.cancelRequest()
  }

  func fetch(image url: String, from cache: ImageCache) -> UIImage? {
    return cache.object(forKey: url as AnyObject)
  }
  
  func loadImage(with url: String, cache: ImageCache,
                 completion: @escaping (UIImage?) -> Void) {
    networkService.downloadImage(url: url) { [weak self] result in
      switch result {
      case let .success(data):
        let image = UIImage(data: data)
        self?.cacheImage(image, url, cache: cache)
        completion(image)
      case .failure: completion(nil)
      }
    }
  }

  private func cacheImage(_ image: UIImage?, _ key: String, cache: ImageCache) {
    guard let image = image else { return }

    cache.setObject(image, forKey: key as AnyObject)
  }
}
