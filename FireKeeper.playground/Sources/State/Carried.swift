import GameplayKit

class Carried: PlayerState {    
    override func didEnter(from previousState: GKState?) {
        print("You are being carried and loosing life")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        player.clampedEnergy -= energyLossrRate
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Aiming.Type ||
            stateClass is Collected.Type
    }
}
