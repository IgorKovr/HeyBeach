import Foundation

final class Error: Swift.Error {
  
  private enum ErrorState {
    case network
    case generic
  }
  
  private let state: ErrorState
  
  init(_ networkError: NetworkError) {
    switch networkError {
    case .api, .noData, .unableToDecode, .canceled:
      state = .generic
    case .network:
      state = .network
    }
  }
  
  var localizedDescription: String {
    switch state {
    case .generic:
      return "Oops, something went wrong"
    case .network:
      return "Please check your internet connection"
    }
  }
}
