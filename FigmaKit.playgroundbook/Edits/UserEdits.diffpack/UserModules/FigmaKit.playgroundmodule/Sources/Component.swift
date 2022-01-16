/// A Figma component.
///
/// "A description of a main component. Helps you identify which component instances are attached to."
/// https://www.figma.com/developers/api#component-type
public struct Component: Codable {
    public let key: String
    public let name: String
    public let description: String
    public let documentationLinks: [DocumentationLink]
    public let componentSetId: String?
}
