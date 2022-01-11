public final class File: Codable, CustomStringConvertible {
    public let name: String
    public let lastModified: String
    public let thumbnailUrl: String
    public let schemaVersion: Int
    public let role: Role
    public let version: String
    public let linkAccess: LinkAccess
    public let document: Node.Document
    
    public enum Role: String, Codable {
        case owner = "owner"
    }
    
    public enum LinkAccess: String, Codable {
        case inherit = "inherit"
        case view = "view"
        case edit = "edit"
        case orgView = "org_view"
        case orgEdit = "org_edit"
    }
    
    public var description: String {
        return """
            <File
            - name: \(name)
            - lastModified: \(lastModified)
            - thumbnailUrl: \(thumbnailUrl)
            - schemaVersion: \(schemaVersion)
            - role: \(role)
            - version: \(version)
            - linkAccess: \(linkAccess)
            - document:
            \(document.debugDescription.indented(by: 2))
            >
            """
    }
}
