struct AuthParameters: Encodable, HTTPParametersConvertable {

  let email: String
  let password: String
}
