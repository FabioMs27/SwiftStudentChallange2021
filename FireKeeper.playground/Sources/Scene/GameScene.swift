import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    private let cameraNode = SKCameraNode()
    private let walls = Walls()
    private let powerUpSpawner = PowerUpSpawn()
    public lazy var player: Player = { [weak self] in
        guard let self = self else { fatalError() }
        let player = Player()
        let stateMachine = GKStateMachine(states: [
            Launch(self), Finished(self),
            Aiming(self), Carried(self),
            Collected(self), Falling(self),
            Start(self)
        ])
        stateMachine.enter(Start.self)
        player.stateMachine = stateMachine
        player.position = .zero
        player.fireEmitter.targetNode = self
        return player
    }()
    public lazy var aim: Aim = { [player] in
        let aim = Aim()
        aim.target = player
        return aim
    }()
    public lazy var backgroundEmitter: SKEmitterNode = {
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Fog.sks") else {
            fatalError("Couldn't load file!")
        }
        emitter.particlePositionRange = CGVector(
            dx: Metrics.screenSize.width,
            dy: 0
        )
        emitter.particlePosition.y = Metrics.screenSize.height * 0.8
        emitter.advanceSimulationTime(5)
        return emitter
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
        addChild(backgroundEmitter)
    }
}

//MARK: -Touch handling
public extension GameScene {
    override func touchesBegan(with event: NSEvent) {
        let position = event.location(in: self)
        aim.initialPos = position
    }
    
    override func touchesMoved(with event: NSEvent) {
        let position = event.location(in: self)
        aim.currentPos = position
        player.enter(state: .aiming)
    }
    
    override func touchesEnded(with event: NSEvent) {
        if aim.currentPos != aim.initialPos {
            let angle = aim.angle + .pi/2
            player.launchAngle = angle
            aim.currentPos = .zero
            aim.initialPos = .zero
            player.enter(state: .launch)
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
            player.enter(state: .collected)
        }
        
        if physics.contains(.floor), physics.contains(.player) {
            player.enter(state: .carried)
        }
    }
}

//MARK: -Update
extension GameScene {
    public override func update(_ currentTime: TimeInterval) {
        player.stateMachine?.currentState?.update(deltaTime: currentTime)
    }
}
