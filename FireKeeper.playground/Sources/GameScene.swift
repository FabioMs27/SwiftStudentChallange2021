import SpriteKit

public class GameScene: SKScene {
    private let walls = Walls()
    private lazy var player: Player = {
        let player = Player()
        player.position = .zero
        return player
    }()
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .black
        setupNodes()
    }
    
    public override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNodes() {
        walls.position = .zero
        addChild(walls)
        addChild(player)
    }
}



