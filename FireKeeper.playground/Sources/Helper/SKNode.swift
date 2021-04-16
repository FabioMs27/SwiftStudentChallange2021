import SpriteKit

public extension SKNode {
    var childrenRecursively: [SKNode] {
        children + children.flatMap { $0.childrenRecursively }
    }
}
