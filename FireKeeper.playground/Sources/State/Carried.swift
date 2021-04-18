import GameplayKit

class Carried: PlayerState {
    override func didEnter(from previousState: GKState?) {
        player.burn()
    }
    
    override func willExit(to nextState: GKState) {
        if !nextState.isMember(of: Aiming.self) {
            player.endBurning()
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        player.clampedEnergy -= energyLossrRate
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Aiming.Type ||
            stateClass is Collected.Type ||
            stateClass is Finished.Type
    }
}
