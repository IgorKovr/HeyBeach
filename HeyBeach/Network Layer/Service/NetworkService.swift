import Foundation

struct NetworkService {

  private let networkRouter: NetworkRouter

  init(networkRouter: NetworkRouter = NetworkRouterImpl()) {
    self.networkRouter = networkRouter
  }

  func cancelRequest() {
    networkRouter.cancelRequest()
  }

  func userLogin(with parameters: AuthParameters, completion: @escaping (NetworkResult<AuthResponse>) ->()) {
    authRequest(endpoint: .login,
                parameters: parameters,
                completion: completion)
  }

  func logout(token: String, completion: @escaping (NetworkResultEmpty) ->()) {
    requestWithEmptyResponse(endpoint: .logout(token: token),
                             completion: completion)
  }

  func userRegister(with parameters: AuthParameters, completion: @escaping (NetworkResult<AuthResponse>) ->()) {
    authRequest(endpoint: .register,
                parameters: parameters,
                completion: completion)
  }

  func fetchImagesList(page: UInt, completion: @escaping (NetworkResult<[ImageResponse]>) ->()) {
    request(endpoint: .beaches(page: page),
            completion: completion)
  }

  func downloadImage(url: String, completion: @escaping (NetworkResult<Data>) ->()) {
    dataRequest(endpoint: .image(url: url),
                completion: completion)
  }
}

private extension NetworkService {
  
  private func request<T>(endpoint: Endpoint,
                          parameters: HTTPParametersConvertable? = nil,
                          completion: @escaping (NetworkResult<T>) ->()) where T : Decodable {
    networkRouter.request(endpoint, parameters: parameters) { (data, response, error) in
      if let error = self.buildError(response, error: error) {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      guard let result = try? JSONDecoder().decode(T.self, from: data) else {
        completion(.failure(.unableToDecode))
        return
      }
      
      completion(.success(result))
    }
  }
  
  private func authRequest(endpoint: Endpoint,
                           parameters: HTTPParametersConvertable? = nil,
                           completion: @escaping (NetworkResult<AuthResponse>) ->()) {
    networkRouter.request(endpoint, parameters: parameters) { (data, response, error) in
      if let error = self.buildError(response, error: error) {
        completion(.failure(error))
        return
      }
      
      guard let response = (response as? HTTPURLResponse),
        let token = response.allHeaderFields[AuthResponse.tokenKey] as? String else {
        completion(.failure(.unableToDecode))
        return
      }
      
      completion(.success(AuthResponse(token: token)))
    }
  }
  
  private func dataRequest(endpoint: Endpoint,
                           parameters: HTTPParametersConvertable? = nil,
                           completion: @escaping (NetworkResult<Data>) ->()) {
    networkRouter.request(endpoint, parameters: parameters) { (data, response, error) in
      if let error = self.buildError(response, error: error) {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      completion(.success(data))
    }
  }

  private func requestWithEmptyResponse(endpoint: Endpoint,
                                        parameters: HTTPParametersConvertable? = nil,
                                        completion: @escaping (NetworkResultEmpty) ->()) {
    networkRouter.request(endpoint, parameters: parameters) { (data, response, error) in
      if let error = self.buildError(response, error: error) {
        completion(.failure(error))
        return
      }

      completion(.success)
    }
  }

  private func buildError(_ response: URLResponse?, error: Swift.Error?) -> NetworkError? {
    if let error = error as NSError?, error.code == NSURLErrorCancelled {
      return .canceled
    }

    guard error == nil else {
      return .network
    }

    guard let response = (response as? HTTPURLResponse),
      200...299 ~= response.statusCode else {
        return .api
    }

    return nil
  }
}
