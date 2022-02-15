/// A Figma images response.
///
/// This object is the response from requests to Figma's get images endpoint:
/// https://www.figma.com/developers/api#get-images-endpoint.
public struct Images: Codable {
  public let err: String?
  public let images: [String: String]
}
