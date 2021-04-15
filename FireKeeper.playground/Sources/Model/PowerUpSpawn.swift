import SpriteKit

public enum PUSettings {
    static let stackMax = 5
    static let coolDownTime: TimeInterval = 4
    static let maxOnScreen = 2
    static let fallSpeed: TimeInterval = 10
    static let fireEnergy: CGFloat = 90
}

public class PowerUpSpawn: SKNode {
    private lazy var powerUpStack: [SKEmitterNode] = { [getPowerUp] in
        var stack = [SKEmitterNode]()
        for _ in 0...PUSettings.stackMax {
            stack.append(getPowerUp())
        }
        return stack
    }()
    
    public override init() {
        super.init()
        setUpBehavior()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getPowerUp() -> SKEmitterNode {
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Burst.sks") else {
            fatalError("Couldn't load file!")
        }
        return emitter
    }
    
    private func getPhysics() -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(circleOfRadius: 20)
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = PhysicsCategory.powerUp.rawValue
        physicsBody.contactTestBitMask = PhysicsCategory.player.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.none.rawValue
        return physicsBody
    }
    
    private func setUpBehavior() {
        let yPos = Metrics.screenSize.height
        let xDistance = Metrics.screenSize.width * 0.4
        
        let waitAction: SKAction = .wait(forDuration: PUSettings.coolDownTime)
        let spawn: SKAction = .run { [spawnPowerUp] in
            let xPos: CGFloat = .random(in: -xDistance...xDistance)
            let spawnPos = CGPoint(x: xPos, y: yPos)
            spawnPowerUp(spawnPos)
        }
        let sequence: SKAction = .sequence([waitAction, spawn])
        let repeatAction: SKAction = .repeatForever(sequence)
        run(repeatAction)
    }
    
    private func spawnPowerUp(at point: CGPoint) {
        if children.count >= PUSettings.maxOnScreen, powerUpStack.isEmpty { return }
        let powerUp = powerUpStack.removeFirst()
        powerUp.position = point
        let finalPos = CGVector(dx: 0, dy: -Metrics.screenSize.height * 2)
        let fallAction: SKAction = .move(by: finalPos, duration: PUSettings.fallSpeed)
        powerUp.isHidden = false
        powerUp.physicsBody = getPhysics()
        addChild(powerUp)
        powerUp.run(fallAction) { [weak self] in
            self?.powerUpStack.append(powerUp)
            powerUp.removeFromParent()
        }
    }
}
