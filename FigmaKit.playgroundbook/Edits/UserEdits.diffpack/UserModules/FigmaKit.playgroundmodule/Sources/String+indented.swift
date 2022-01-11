extension String {
    func indented(by indent: Int) -> String {
        let indentString = String(repeating: " ", count: indent)
        return self.split(whereSeparator: \.isNewline).map {
            indentString + $0
        }.joined(separator: "\n")
    }
}
