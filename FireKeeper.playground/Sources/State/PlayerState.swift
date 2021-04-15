import GameplayKit

class PlayerState: GKState {
    unowned let scene: GameScene
    var player: Player { scene.player }
    var aim: Aim { scene.aim }
    public init(_ scene: GameScene) {
        self.scene = scene
    }
}
