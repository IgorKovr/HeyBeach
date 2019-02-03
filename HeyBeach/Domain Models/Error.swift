import Foundation

final class Error: Swift.Error {
  
  private enum ErrorState {
    case network
    case request
  }
  
  private let state: ErrorState
  
  init(_ networkError: NetworkError) {
    switch networkError {
    case .api, .noData, .unableToDecode:
      state = .request
    case .network:
      state = .network
    }
  }
  
  var localizedDescription: String {
    switch state {
    case .request:
      return "Oops, something went wrong"
    case .network:
      return "Please check your internet connection"
    }
  }
}
