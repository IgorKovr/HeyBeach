import Foundation

enum Endpoint {
  
  case login
  case register
  case user
  case logout
  case beaches(page: UInt)
  case image(url: String)
}

extension Endpoint {
  
  var url: URL {
    guard let url = URL(string: baseURL.appending(path)) else {
      fatalError("Couldn't build URL")
    }
    
    return url
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .register: return .post
    case .login: return .post
    case .user: return .get
    case .logout: return .delete
    case .beaches: return .get
    case .image: return .get
    }
  }
  
  private var baseURL: String { return "http://techtest.lab1886.io:3000/" }
  
  private var path: String {
    switch self {
    case .register: return "user/register"
    case .login: return "user/login"
    case .user: return "user/me"
    case .logout: return "user/logout"
    case let .beaches(page): return "beaches?page=\(page)"
    case let .image(url): return url
    }
  }
}
