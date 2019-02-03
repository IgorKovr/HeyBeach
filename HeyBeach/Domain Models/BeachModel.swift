import Foundation

struct BeachModel {
  
  let url: String
  let title: String
  let width: String
  let height: String
}

extension BeachModel {
  
  init(_ imageResponse: ImageResponse) {
    url = imageResponse.url
    title = imageResponse.name
    width = imageResponse.width
    height = imageResponse.height
  }
}
