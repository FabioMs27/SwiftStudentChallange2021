import SpriteKit

public class Player: SKNode {
    
    public lazy var fireEmitter: SKEmitterNode = {
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Fire.sks") else {
            fatalError("File couldn't load!")
        }
        return emitter
    }()
    
    public override init() {
        super.init()
        addPhysics()
        addChild(fireEmitter)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPhysics() {
        let physicsBody = SKPhysicsBody(circleOfRadius: 15)
        physicsBody.isDynamic = true
        physicsBody.affectedByGravity = true
        physicsBody.categoryBitMask = PhysicsCategory.player.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.floor.rawValue
        physicsBody.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.floor.rawValue | PhysicsCategory.powerUp.rawValue
        self.physicsBody = physicsBody
    }
}

