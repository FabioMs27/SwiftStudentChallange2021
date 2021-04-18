import GameplayKit

class Falling: PlayerState {
    
    override func didEnter(from previousState: GKState?) {
        if player.isGrounded { player.enter(state: .carried) }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Aiming.Type ||
            stateClass is Collected.Type ||
            stateClass is Carried.Type ||
            stateClass is Finished.Type
    }
}
