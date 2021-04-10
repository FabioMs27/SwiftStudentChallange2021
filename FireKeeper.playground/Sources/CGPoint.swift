import Foundation

public extension CGPoint {
    func angleTo(point: CGPoint) -> CGFloat {
        let originX = point.x - self.x
        let originY = point.y - self.y
        var radians = atan2(originY, originX)
        while radians < 0 {
            radians += CGFloat(2 * Double.pi)
        }
        return radians
    }
    
    static func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
