/// A Figma flow starting point.
///
/// "A flow starting point used when launching a prototype to enter Presentation view."
/// https://www.figma.com/developers/api#flowstartingpoint-type
public struct FlowStartingPoint: Codable {
    /// Unique identifier specifying the frame.
    public let nodeId: String
    /// Name of flow
    public let name: String
}
