import Foundation

struct ImageResponse {

  let url: String
  let name: String
  let width: String
  let height: String
}

extension ImageResponse: Decodable {

  enum CodingKeys : String, CodingKey {
    case url = "url"
    case name = "name"
    case width = "width"
    case height = "height"
  }
}
