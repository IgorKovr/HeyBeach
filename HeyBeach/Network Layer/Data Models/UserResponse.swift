import Foundation

struct UserResponse {
  
  let name: String
}

extension UserResponse: Decodable {
  
  enum CodingKeys : String, CodingKey {
    case name = "name"
  }
}
