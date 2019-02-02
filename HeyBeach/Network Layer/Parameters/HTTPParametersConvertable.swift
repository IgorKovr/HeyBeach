import Foundation

protocol HTTPParametersConvertable {

  func httpParameters() throws -> Data
}

extension HTTPParametersConvertable where Self: Encodable {

  func httpParameters() throws -> Data {
    return try JSONEncoder().encode(self)
  }
}
