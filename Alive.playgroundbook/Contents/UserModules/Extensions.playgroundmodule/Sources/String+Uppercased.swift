extension StringProtocol {
    public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    public var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
