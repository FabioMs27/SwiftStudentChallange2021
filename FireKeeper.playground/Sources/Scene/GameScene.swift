import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    private let walls = Walls()
    private lazy var player: Player = { [weak self] in
        let player = Player()
        let stateMachine = GKStateMachine(states: [])
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
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNodes() {
        addChild(walls)
        addChild(player)
    }
}

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
            aim.currentPos = .zero
            aim.initialPos = .zero
            player.launch(to: angle)
        }
    }
}
