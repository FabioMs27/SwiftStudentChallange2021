import SpriteKit

public class GameScene: SKScene {
    private let walls = Walls()
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        walls.position = .zero
        addChild(walls)
        backgroundColor = .white
    }
    
    public override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



