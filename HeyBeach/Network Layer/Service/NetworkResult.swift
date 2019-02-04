import Foundation

enum NetworkResult<T> {
  case success(T)
  case failure(NetworkError)
}

enum NetworkResultEmpty {
  case success
  case failure(NetworkError)
}
