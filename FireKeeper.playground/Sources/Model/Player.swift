import SpriteKit
import GameplayKit

public class Player: SKNode {
    
    public var stateMachine: GKStateMachine?
    public let force: CGFloat = 30
    public let maxEnergy: CGFloat = 100
    public let launchEnergy: CGFloat = 5
    public var launchAngle: CGFloat = 0
    private var lastColor: CGColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
    
    public lazy var fireEmitter: SKEmitterNode = { [weak self] in
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Fire.sks") else {
            fatalError("File couldn't load!")
        }
        self?.lastColor = emitter.particleColor.cgColor
        Metrics.defaultFireColor = emitter.particleColor.cgColor
        Metrics.defaultFireBirthRate = emitter.particleBirthRate
        return emitter
    }()
    
    public lazy var burnEmitter: SKEmitterNode = { [weak self] in
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Burning.sks") else {
            fatalError("Couldn't load file!")
        }
        self?.burningRate = emitter.particleBirthRate
        return emitter
    }()
    
    public lazy var fireLight: SKLightNode = {
        let lightNode = SKLightNode()
        lightNode.categoryBitMask = 0b0001
        lightNode.lightColor = .white
        return lightNode
    }()
    
    private var burningRate = CGFloat()
    
    public override init() {
        super.init()
        addPhysics()
        addChild(fireEmitter)
        addChild(burnEmitter)
        addChild(fireLight)
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
        guard let fireSettings = FireStates.getFireSettings(basedOn: energy),
              let color = SKColor(cgColor: fireSettings.color),
              lastColor != fireSettings.color else {
            return
        }
        fireEmitter.particleBirthRate = fireSettings.birthRate
        fireEmitter.particleColor = color
        lastColor = fireSettings.color
        print(color)
    }
}

