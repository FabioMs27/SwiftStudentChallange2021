import GameplayKit

class Start: PlayerState {
    var emitter: SKEmitterNode {
        scene.backgroundEmitter
    }
    
    var canStart = false
    
    override func didEnter(from previousState: GKState?) {
        MusicManager.shared.playMusic()
        MusicManager.shared.playAudio1()
        startIntro()
    }
    
    override func willExit(to nextState: GKState) {
        player.addPhysics()
        scene.powerUpSpawner.setUpBehavior()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        canStart && stateClass is Aiming.Type
    }
}

extension Start {
    func startIntro() {
        let goToCenterAction: SKAction = .move(to: .zero, duration: 5)
        let addConfig: SKAction = .run(configGame)
        player.run(.sequence([
            goToCenterAction,
            addConfig
        ]))
    }
    
    func configGame() {
        canStart = true
        player.fireEmitter.targetNode = scene
    }
}
