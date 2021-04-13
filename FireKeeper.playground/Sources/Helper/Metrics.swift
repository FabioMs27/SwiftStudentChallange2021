import Foundation

public enum Metrics {
    public static let screenSize = CGSize(width: 640, height: 480)
    public static let gravity = CGVector(dx: 0, dy: -9.8)
    public static let anchorPoint = CGPoint(x: 0.5, y: 0.5)
    public static let outOfBounds = CGPoint(x: -Self.screenSize.width, y: 0)
}

