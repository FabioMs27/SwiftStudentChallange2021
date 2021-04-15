import GameplayKit

class Carried: PlayerState {
    var lastTime:TimeInterval = 0.1
//    let updateRate: Double = 0.2
    let energyLossrRate: CGFloat = 0.1
    
    override func didEnter(from previousState: GKState?) {
        print("You are being carried and loosing life")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        player.energySetter -= energyLossrRate
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Aiming.Type ||
            stateClass is Collected.Type
    }
}
