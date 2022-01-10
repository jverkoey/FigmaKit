/// A Figma affine transformation matrix.
///
/// "A 2D affine transformation matrix that can be used to calculate
/// the affine transforms applied to a layer, including scaling, rotation,
/// shearing, and translation. The form of the matrix is given as an array
/// of 2 arrays of 3 numbers each. E.g. the identity matrix would be
/// [[1, 0, 0], [0, 1, 0]]."
/// https://www.figma.com/developers/api#transform-type
public struct Transform: Codable {
    /// The first row of the matrix.
    public let row1: [Double]
    /// The second row of the matrix.
    public let row2: [Double]
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        self.row1 = try container.decode([Double].self)
        self.row2 = try container.decode([Double].self)
    }
}
