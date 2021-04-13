import SpriteKit
import GameplayKit

public class Player: SKNode {
    
    public var stateMachine: GKStateMachine?
    public let force: CGFloat = 30
    public var launchAngle: CGFloat = 0
    
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
        physicsBody.allowsRotation = false
        physicsBody.friction = 1
        physicsBody.restitution = 0
        physicsBody.categoryBitMask = PhysicsCategory.player.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.floor.rawValue
        physicsBody.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.floor.rawValue | PhysicsCategory.powerUp.rawValue
        self.physicsBody = physicsBody
    }
    
    public func enter(state: AnyClass) {
        stateMachine?.enter(state)
    }
    
    public func collectPowerUp() {
        physicsBody?.allContactedBodies()
            .map { $0.node as? SKEmitterNode }
            .forEach {
                $0?.isHidden = true
                $0?.physicsBody = nil
            }
    }
}

