import SpriteKit

public class Walls: SKNode {
    private var wallShape: SKShapeNode {
        let size = CGSize(width: 10, height: screen.width)
        let center = CGPoint(x: -size.width/2, y: -size.height/2)
        let rect = CGRect(origin: center, size: size)
        let shape = SKShapeNode(rect: rect)
        shape.fillColor = .clear
        return shape
    }
    private var screen: CGSize {
        Metrics.screenSize
    }
    private lazy var settings: [(position: CGPoint, rotation: CGFloat, category: PhysicsCategory)] = [
        (position: CGPoint(x: screen.width/2, y: 0), rotation: 0, category: .wall),
        (position: CGPoint(x: -screen.width/2, y: 0), rotation: 0, category: .wall),
        (position: CGPoint(x: 0, y: screen.height/2), rotation: .pi/2, category: .wall),
        (position: CGPoint(x: 0, y: -screen.height/2), rotation: .pi/2, category: .floor)
    ]
    
    public override init() {
        super.init()
        setupWalls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWalls() {
        for setting in settings {
            let wall = wallShape
            wall.position = setting.position
            wall.zRotation = setting.rotation
            wall.physicsBody = getPhysics(category: setting.category)
            addChild(wall)
        }
    }
    
    private func getPhysics(category: PhysicsCategory) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody()
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = category.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.player.rawValue
        physicsBody.contactTestBitMask = category == .floor ? PhysicsCategory.player.rawValue : PhysicsCategory.none.rawValue
        return physicsBody
    }
}
