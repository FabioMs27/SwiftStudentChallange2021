import GameplayKit

class Start: PlayerState {
    var emitter: SKEmitterNode {
        scene.backgroundEmitter
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Press to start")
//        emitter.particleBirthRate = 25
//        emitter.yAcceleration = -1000
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Falling.Type ||
            stateClass is Carried.Type
    }
}
