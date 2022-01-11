import FigmaKit
import Foundation
import XCTest

public final class FileTests: XCTestCase {
    public func testDecodeEmptyDocument() throws {
        let json = """
        {
            "schemaVersion": 0,
            "styles": {},
            "name": "Untitled",
            "lastModified": "2022-01-09T00:08:04Z",
            "thumbnailUrl": "figma.com",
            "version": "1439652218",
            "role": "owner",
            "editorType": "figma",
            "linkAccess": "view",
            "document": {
                "id": "0:0",
                "name": "Document",
                "type": "DOCUMENT",
            }
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let file = try decoder.decode(File.self, from: json)
        
        XCTAssertEqual(file.schemaVersion, 0)
        XCTAssertEqual(file.name, "Untitled")
        XCTAssertEqual(file.lastModified, "2022-01-09T00:08:04Z")
        XCTAssertEqual(file.thumbnailUrl, "figma.com")
        XCTAssertEqual(file.version, "1439652218")
        XCTAssertEqual(file.role, .owner)
        XCTAssertEqual(file.linkAccess, .view)
        XCTAssertEqual(file.document.id, "0:0")
        XCTAssertEqual(file.document.name, "Document")
        XCTAssertTrue(file.document.children.isEmpty)
    }
    
    public func testDecodeDocumentWithOnePage() throws {
        let json = """
        {
            "schemaVersion": 0,
            "styles": {},
            "name": "Untitled",
            "lastModified": "2022-01-09T00:08:04Z",
            "thumbnailUrl": "figma.com",
            "version": "1439652218",
            "role": "owner",
            "editorType": "figma",
            "linkAccess": "view",
            "document": {
                "id": "0:0",
                "name": "Document",
                "type": "DOCUMENT",
                "children": [{
                    "id": "0:1",
                    "name": "Page 1",
                    "type": "CANVAS",
                    "backgroundColor": {
                        "r":0.89803922176361084,
                        "g":0.89803922176361084,
                        "b":0.89803922176361084,
                        "a":1.0
                    },
                }]
            }
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let file = try decoder.decode(File.self, from: json)
        
        XCTAssertEqual(file.document.children.count, 1)
        let canvas = try XCTUnwrap(file.document.children.first as? Node.Canvas)
        XCTAssertTrue(canvas.children.isEmpty)
        XCTAssertEqual(canvas.id, "0:1")
        XCTAssertEqual(canvas.name, "Page 1")
    }
    
    public func testDecodeDocumentWithOneFrame() throws {
        let json = """
        {
            "schemaVersion": 0,
            "styles": {},
            "name": "Untitled",
            "lastModified": "2022-01-09T00:08:04Z",
            "thumbnailUrl": "figma.com",
            "version": "1439652218",
            "role": "owner",
            "editorType": "figma",
            "linkAccess": "view",
            "document": {
                "id": "0:0",
                "name": "Document",
                "type": "DOCUMENT",
                "children": [{
                    "id": "0:1",
                    "name": "Page 1",
                    "type": "CANVAS",
                    "backgroundColor": {
                        "r":0.89803922176361084,
                        "g":0.89803922176361084,
                        "b":0.89803922176361084,
                        "a":1.0
                    },
                    "children": [{
                        "id": "2:2",
                        "name": "Rectangle 1",
                        "type": "RECTANGLE",
                        "blendMode": "PASS_THROUGH",
                        "absoluteBoundingBox": {
                            "x": -121.0,
                            "y": -202.0,
                            "width": 334.0,
                            "height": 139.0
                        },
                        "constraints": {
                            "vertical": "TOP",
                            "horizontal": "LEFT"
                        },
                        "relativeTransform":[
                            [1.0, 0.0, -121.0],
                            [0.0, 1.0, -202.0]
                        ],
                        "size": {
                            "x": 334.0,
                            "y": 139.0
                        },
                        "fills": [{
                            "blendMode": "NORMAL",
                            "type": "SOLID",
                            "color": {
                                "r": 0.0,
                                "g": 0.3,
                                "b": 1.0,
                                "a": 1.0
                            }
                        }],
                        "fillGeometry": [{
                            "path": "M0 0L334 0L334 139L0 139L0 0Z",
                            "windingRule": "NONZERO"
                        }],
                        "strokes": [],
                        "strokeWeight": 1.0,
                        "strokeAlign": "INSIDE",
                        "strokeGeometry": [],
                        "effects": []
                    }]
                }]
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let file = try decoder.decode(File.self, from: json)
        
        XCTAssertEqual(file.document.children.count, 1)
        let canvas = try XCTUnwrap(file.document.children.first as? Node.Canvas)
        XCTAssertEqual(canvas.children.count, 1)
        
        let rect = try XCTUnwrap(canvas.children.first as? Node.Rectangle)
        XCTAssertEqual(rect.id, "2:2")
        XCTAssertEqual(rect.name, "Rectangle 1")
        XCTAssertEqual(rect.absoluteBoundingBox.x, -121)
        XCTAssertEqual(rect.absoluteBoundingBox.y, -202)
        XCTAssertEqual(rect.absoluteBoundingBox.width, 334)
        XCTAssertEqual(rect.absoluteBoundingBox.height, 139)
        XCTAssertEqual(rect.relativeTransform.row1, [1, 0, -121])
        XCTAssertEqual(rect.relativeTransform.row2, [0, 1, -202])
        XCTAssertEqual(rect.size.x, 334)
        XCTAssertEqual(rect.size.y, 139)
        XCTAssertTrue(rect.children.isEmpty)
        XCTAssertEqual(rect.fills.count, 1)
        
        let fill = try XCTUnwrap(rect.fills.first as? Paint.Solid)
        XCTAssertTrue(fill.visible)
        XCTAssertEqual(fill.opacity, 1)
        XCTAssertEqual(fill.color.r, 0)
        XCTAssertEqual(fill.color.g, 0.3)
        XCTAssertEqual(fill.color.b, 1)
        XCTAssertEqual(fill.color.a, 1)
    }
}
