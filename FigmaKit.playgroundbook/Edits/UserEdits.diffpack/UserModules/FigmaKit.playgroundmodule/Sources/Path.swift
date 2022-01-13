import Foundation

/// A Figma path.
///
/// "A series of path commands that encodes how to draw the path."
/// https://www.figma.com/plugin-docs/api/properties/VectorPath-data/
public struct Path: Codable {
    /// A series of path commands that encodes how to draw the path.
    ///
    /// Figma supports a subset of the SVG path format. Path commands must be
    /// joined into a single string in order separated by a single space.
    ///
    /// Supported commands:
    /// - `M x y`: The absolute "move to" command.
    /// - `L x y`: The absolute "line to" command.
    /// - `Q x0 y0 x y`: The absolute "quadratic spline to" command. All quadratic splines are converted to cubic splines by Figma.
    /// - `C x0 y0 x1 y1 x y`: The absolute "cubic spline to" command.
    /// - `Z`: The "close path" command.
    public let path: String
    /// Determines whether a given point in space is inside or outside the path.
    public let windingRule: WindingRule
    
    /// Determines whether a given point in space is inside or outside the path.
    ///
    /// Winding rules work off a concept called the winding number, which tells you
    /// for a given point how many times the path winds around that point.
    public enum WindingRule: String, Codable {
        /// The point is considered inside the path if the winding number is NONZERO.
        case nonZero = "NONZERO"
        /// The point is considered inside the path if the winding number is odd.
        case evenOdd = "EVENODD"
        /// An open path won’t have a fill.
        case none = "NONE"
    }
    
    public enum Command {
        case moveTo(x: Double, y: Double)
        case lineTo(x: Double, y: Double)
        case splineTo(x0: Double, y0: Double, x1: Double, y1: Double, x: Double, y: Double)
        case close
    }
    
    /// Returns a parsed representation of the Figma path string.
    public func commands() -> [Command] {
        let scanner = Scanner(string: path)
        
        var commands: [Command] = []
        while !scanner.isAtEnd {
            let commandCode = scanner.scanCharacter()
            
            switch commandCode {
            case "M":
                guard let x = scanner.scanDouble(),
                      let y = scanner.scanDouble() else {
                    fatalError("Malformed command")
                }
                commands.append(.moveTo(x: x, y: y))
            case "L":
                guard let x = scanner.scanDouble(),
                      let y = scanner.scanDouble() else {
                    fatalError("Malformed command")
                }
                commands.append(.lineTo(x: x, y: y))
            case "C":
                guard let x0 = scanner.scanDouble(),
                      let y0 = scanner.scanDouble(),
                      let x1 = scanner.scanDouble(),
                      let y1 = scanner.scanDouble(),
                      let x = scanner.scanDouble(),
                      let y = scanner.scanDouble() else {
                    fatalError("Malformed command")
                }
                commands.append(.splineTo(x0: x0, y0: y0, x1: x1, y1: y1, x: x, y: y))
            case "Z":
                commands.append(.close)
            default:
                fatalError("Not implemented: \(commandCode)")
            }
        }
        return commands
    }
    
    /// Returns a parsed representation of the Figma path string, where the given offset has been added to every point.
    public func commands(offsetBy offset: (x: Double, y: Double)) -> [Command] {
        return commands().map { command in
            switch command {
            case let .moveTo(x, y):
                return .moveTo(x: x + offset.x, y: y + offset.y)
            case let .lineTo(x, y):
                return .lineTo(x: x + offset.x, y: y + offset.y)
            case let .splineTo(x0, y0, x1, y1, x, y):
                return .splineTo(
                    x0: x0 + offset.x, y0: y0 + offset.y,
                    x1: x1 + offset.x, y1: y1 + offset.y,
                    x: x + offset.x, y: y + offset.y
                )
            case .close:
                return .close
            }
        }
    }
    
    /// Returns the bounds of all points in the commands.
    public func bounds() -> (minX: Double, minY: Double, maxX: Double, maxY: Double)? {
        var bounds: (minX: Double, minY: Double, maxX: Double, maxY: Double)? = nil
        for command in commands() {
            switch command {
            case let .moveTo(x, y),
                 let .lineTo(x, y),
                 let .splineTo(_, _, _, _, x, y):
                if let oldBounds = bounds {
                    bounds = (min(oldBounds.minX, x), min(oldBounds.minY, y),
                              max(oldBounds.maxX, x), max(oldBounds.maxY, y))
                } else {
                    bounds = (x, y, x, y)
                }
            case .close:
                break
            }
        }
        return bounds
    }
}
