import SpriteKit

public class Aim: SKNode {
    public var target: SKNode? {
        willSet {
            removeFromParent()
            newValue?.addChild(self)
        }
    }
    private lazy var aimEmitter: SKEmitterNode = {
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Aim.sks") else {
            fatalError("Failed to load aim emitter!")
        }
        return emitter
    }()
    public var initialPos: CGPoint = .zero
    public var currentPos: CGPoint = .zero {
        didSet { updateAimingTrail() }
    }
    public var angle: CGFloat {
        initialPos.angleTo(point: currentPos) + .pi
    }
    
    public override init() {
        super.init()
        addChild(aimEmitter)
        alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fadeIn() {
        removeAllActions()
        let fadeAction = SKAction.fadeAlpha(to: 1, duration: 0.5)
        run(fadeAction)
    }
    
    public func fadeOut() {
        removeAllActions()
        alpha = 0
    }
    
    private func updateAimingTrail() {
        zRotation = angle
    }
}
