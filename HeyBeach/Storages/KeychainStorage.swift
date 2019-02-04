import Foundation
import Security

extension KeychainStorage: Storage {

  func stringValue(for key: StorageKey) -> String? {
    return self.loadPassword(serviceKey: key.rawValue)
  }

  func set(string value: String, for key: StorageKey) {
    self.updatePassword(value, serviceKey: key.rawValue)
  }

  func flush() {
    self.removeAllPasswords()
  }
}

class KeychainStorage {

  private func updatePassword(_ password: String, serviceKey: String) {
    guard let dataFromString = password.data(using: .utf8) else { return }

    let keychainQuery: [CFString : Any] = [kSecClass: kSecClassGenericPassword,
                                           kSecAttrService: serviceKey,
                                           kSecValueData: dataFromString]
    SecItemDelete(keychainQuery as CFDictionary)
    SecItemAdd(keychainQuery as CFDictionary, nil)
  }


  private func loadPassword(serviceKey: String) -> String? {
    let keychainQuery: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                           kSecAttrService : serviceKey,
                                           kSecReturnData: kCFBooleanTrue,
                                           kSecMatchLimitOne: kSecMatchLimitOne]
    var dataTypeRef: AnyObject?
    SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
    guard let retrievedData = dataTypeRef as? Data else { return nil }

    return String(data: retrievedData, encoding: .utf8)
  }

  private func removeAllPasswords()  {
    let secItemClasses =  [kSecClassGenericPassword]
    for itemClass in secItemClasses {
      let spec: NSDictionary = [kSecClass: itemClass]
      SecItemDelete(spec)
    }
  }
}
