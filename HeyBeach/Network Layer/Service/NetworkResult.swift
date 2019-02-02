import Foundation

enum NetworkResult<T>{
  case success(T)
  case failure(NetworkError)
}

enum NetworkError: Swift.Error {
  case network
  case api
  case noData
  case unableToDecode
}
