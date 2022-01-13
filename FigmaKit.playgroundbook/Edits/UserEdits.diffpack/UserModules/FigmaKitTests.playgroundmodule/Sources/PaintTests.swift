import FigmaKit
import Foundation
import XCTest

private struct TestObject: Decodable {
    let paints: [Paint]
    
    private enum CodingKeys: String, CodingKey {
        case paints
    }
    
    init(from decoder: Decoder) throws { 
        let container = try decoder.container(keyedBy: Self.CodingKeys)
        self.paints = try Paint.decodePolymorphicArray(from: container.nestedUnkeyedContainer(forKey: .paints))
    }
}

public final class PaintTests: XCTestCase {
    public func testDecoding() throws {
        let json = """
            {"paints":[
              {
                "blendMode": "NORMAL",
                "type": "SOLID",
                "color": {
                  "r": 0,
                  "g": 0.25,
                  "b": 0.5,
                  "a": 1
                }
              }
            ]}
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let object = try decoder.decode(TestObject.self, from: json)
        
        XCTAssertEqual(object.paints.count, 1)
        let solid = try XCTUnwrap(object.paints.first as? Paint.Solid)
        XCTAssertEqual(solid.color.r, 0)
        XCTAssertEqual(solid.color.g, 0.25)
        XCTAssertEqual(solid.color.b, 0.5)
        XCTAssertEqual(solid.color.a, 1)
        XCTAssertTrue(solid.visible)
        XCTAssertEqual(solid.opacity, 1)
    }
}
