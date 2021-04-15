import GameplayKit

class Collected: PlayerState {
    override func didEnter(from previousState: GKState?) {
        player.collectPowerUp()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Aiming.Type ||
            stateClass is Finished.Type ||
            stateClass is Falling.Type ||
            stateClass is Carried.Type
    }
}
