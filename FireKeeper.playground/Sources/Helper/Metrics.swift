import Foundation

public enum Metrics {
    public static let screenSize = CGSize(width: 600, height: 650)
    public static let gravity = CGVector(dx: 0, dy: -9.8)
    public static let anchorPoint = CGPoint(x: 0.5, y: 0.5)
    public static let outOfBounds = CGPoint(x: -Self.screenSize.width, y: 0)
    public static var defaultFireBirthRate = CGFloat()
    public static var defaultFireColor: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

