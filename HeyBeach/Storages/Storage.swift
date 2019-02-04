import Foundation

protocol Storage {

  func stringValue(for key: StorageKey) -> String?
  func set(string value: String, for key: StorageKey)
  func flush()
}

enum StorageKey: String {

  case authToken = "kAuthToken"
}
