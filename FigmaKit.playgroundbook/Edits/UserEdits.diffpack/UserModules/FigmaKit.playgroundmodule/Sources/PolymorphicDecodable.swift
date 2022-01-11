/// An object that can be decoded as a subclass based on a type key.
///
/// A class that conforms to this type is expected to define a dictionary of "type values to class types",
/// where each class type must be a descendant of the conforming class. The type value type must also be
/// decodable.
///
/// ```
/// public enum FigmaType: String, Codable {
///   case solid = "SOLID"
/// }
///
/// static let typeMap: [FigmaType: Paint.Type] = [
///   .solid: Solid.self,
/// ]
/// ```
///
/// Classes conforming to this protocol are encouraged to hide the implementation details of this method
/// behind a simpler method like so:
///
/// ```
/// public static func decode(from decoder: UnkeyedDecodingContainer) throws -> [Paint] {
///   return try decodePolyType(from: decoder, keyedBy: Paint.CodingKeys.self, key: .type, typeMap: Paint.typeMap)
/// }
/// ```

protocol PolymorphicDecodable: Decodable {
}

extension PolymorphicDecodable {
    /// Decodes an array of Paint types from an unkeyed container.
    ///
    /// The returned array's values will be instances of the corresponding type of
    /// paint.
    public static func decodePolyType<NestedKey: CodingKey, EncodedType: Decodable>(
        from decoder: UnkeyedDecodingContainer,
        keyedBy codingKeys: NestedKey.Type,
        key: NestedKey,
        typeMap: [EncodedType: Self.Type]
    ) throws -> [Self] {
        var items: [Self] = []
        var itemDecoder = decoder
        var itemTypeDecoder = decoder
        while !itemDecoder.isAtEnd {
            let typeDecoder = try itemTypeDecoder.nestedContainer(keyedBy: codingKeys)
            let decodedType = try typeDecoder.decode(EncodedType.self, forKey: key)
            
            guard let itemType = typeMap[decodedType] else {
                throw DecodingError.typeMismatch(
                    Self.self,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Unknown item type: \(decodedType)"
                    )
                )
            }
            items.append(try itemDecoder.decode(itemType))
        }
        return items
    }
}
