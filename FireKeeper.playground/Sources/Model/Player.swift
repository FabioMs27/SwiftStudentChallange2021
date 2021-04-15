import SpriteKit
import GameplayKit

public enum PlayerStates {
    case carried
    case collected
    case falling
    case finished
    case launch
    case start
    case aiming
    
    public var classType: AnyClass {
        switch self {
        case .carried:   return Carried.self
        case .collected: return Collected.self
        case .falling:   return Falling.self
        case .finished:  return Finished.self
        case .launch:    return Launch.self
        case .start:     return Start.self
        case .aiming:    return Aiming.self
        }
    }
}

public class Player: SKNode {
    
    public var stateMachine: GKStateMachine?
    public let force: CGFloat = 30
    public let maxEnergy: CGFloat = 100
    public let launchEnergy: CGFloat = 5
    public var launchAngle: CGFloat = 0
    public var clampedEnergy: CGFloat {
        set {
            if newValue >= maxEnergy {
                energy = maxEnergy
            } else if newValue <= launchEnergy {
                energy = launchEnergy
            } else {
                energy = newValue
            }
        }
        get { energy }
    }
    public var energy: CGFloat = 10 {
        didSet { updateFireStrength() }
    }
    public var isGrounded: Bool {
        physicsBody?.allContactedBodies()
            .map { ($0.node?.physicsBody?.categoryBitMask ?? 0) == PhysicsCategory.floor.rawValue }
            .reduce(into: false, { $0 = $0 || $1 } ) ?? false
    }
    
    public lazy var fireEmitter: SKEmitterNode = {
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Fire.sks") else {
            fatalError("File couldn't load!")
        }
        return emitter
    }()
    
    public lazy var burnEmitter: SKEmitterNode = { [weak self] in
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Burning.sks") else {
            fatalError("Couldn't load file!")
        }
        self?.burningRate = emitter.particleBirthRate
        return emitter
    }()
    
    private var burningRate: CGFloat = 0
    
    public override init() {
        super.init()
        addPhysics()
        addChild(fireEmitter)
        addChild(burnEmitter)
        endBurning()
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
    
    public func enter(state: PlayerStates) {
        stateMachine?.enter(state.classType)
    }
    
    public func collectPowerUp() {
        physicsBody?.allContactedBodies()
            .map { $0.node as? SKEmitterNode }
            .filter { $0 != nil }
            .forEach {
                $0?.isHidden = true
                $0?.physicsBody = nil
                clampedEnergy += PUSettings.fireEnergy
            }
    }
    
    public func burn() {
        burnEmitter.particleBirthRate = burningRate
    }
    
    public func endBurning() {
        burnEmitter.particleBirthRate = 0
    }
    
    private func updateFireStrength() {
        if energy == maxEnergy { enter(state: .finished) }
        print(energy)
    }
}

