import GameplayKit

class PlayerState: GKState {
    
    unowned let scene: GameScene
    var player: Player { scene.player }
    var aim: Aim { scene.aim }
    let energyLossrRate: CGFloat = 0.1
    
    public init(_ scene: GameScene) {
        self.scene = scene
    }
    
    func slowMotion(duration: CGFloat, from initialValue: CGFloat, to finalValue: CGFloat){
        scene.physicsWorld.speed = initialValue
        
        let count = 60
        let distance = finalValue - initialValue
        let block = SKAction.run { [scene] in
            let newSpeed = distance/CGFloat(count)
            scene.physicsWorld.speed += newSpeed
        }
        
        let wait = SKAction.wait(forDuration: TimeInterval(duration/CGFloat(count)))
        
        let sequence = SKAction.sequence([wait,block])
        let forLoop = SKAction.repeat(sequence, count: count)
        scene.removeAllActions()
        scene.run(forLoop) { [scene] in
            scene.childrenRecursively
                .forEach { $0.speed = finalValue }
        }
        
    }
    
    func endSlowMotion() {
        scene.removeAllActions()
        scene.physicsWorld.speed = 1
        scene.childrenRecursively
            .forEach { $0.speed = 1 }
    }
}
