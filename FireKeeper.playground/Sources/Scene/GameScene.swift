import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    private let cameraNode = SKCameraNode()
    private let walls = Walls()
    private let powerUpSpawner = PowerUpSpawn()
    private lazy var player: Player = { [weak self] in
        let player = Player()
        let stateMachine = GKStateMachine(states: [
            Launch(player)
        ])
        player.stateMachine = stateMachine
        player.position = .zero
        player.fireEmitter.targetNode = self
        return player
    }()
    private lazy var aim: Aim = { [player] in
        let aim = Aim()
        aim.target = player
        return aim
    }()
    
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .black
        setupNodes()
        aim.position = .zero
    }
    
    public override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = Metrics.anchorPoint
        physicsWorld.gravity = Metrics.gravity
        physicsWorld.contactDelegate = self
        camera = cameraNode
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNodes() {
        addChild(walls)
        addChild(player)
        addChild(powerUpSpawner)
    }
}

//MARK: -Touch handling
public extension GameScene {
    override func touchesBegan(with event: NSEvent) {
        let position = event.location(in: self)
        aim.initialPos = position
        aim.fadeIn()
    }
    
    override func touchesMoved(with event: NSEvent) {
        let position = event.location(in: self)
        aim.currentPos = position
    }
    
    override func touchesEnded(with event: NSEvent) {
        aim.fadeOut()
        if aim.currentPos != aim.initialPos {
            let angle = aim.angle + .pi/2
            player.launchAngle = angle
            aim.currentPos = .zero
            aim.initialPos = .zero
            player.enter(state: Launch.self)
        }
    }
}

//MARK: -Physics Handling
extension GameScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        guard
            let physicsA = contact.bodyA.node?.physicsBody,
            let physicsB = contact.bodyB.node?.physicsBody else {
            return
        }
        
        let physics: [PhysicsCategory] = [
            PhysicsCategory(rawValue: physicsA.categoryBitMask) ?? .none,
            PhysicsCategory(rawValue: physicsB.categoryBitMask) ?? .none
        ]
        
        if physics.contains(.powerUp), physics.contains(.player) {
            player.collectPowerUp()
            print("Coletou")
        }
    }
}
