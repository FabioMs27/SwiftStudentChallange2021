import GameplayKit

class Aiming: PlayerState {
    
    override func didEnter(from previousState: GKState?) {
        aim.removeAllActions()
        let fadeAction = SKAction.fadeAlpha(to: 1, duration: 0.5)
        aim.run(fadeAction)
    }
    override func willExit(to nextState: GKState) {
        aim.removeAllActions()
        aim.alpha = 0
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Launch.Type ||
            stateClass is Collected.Type ||
            stateClass is Carried.Type ||
            stateClass is Launch.Type ||
            stateClass is Falling.Type
    }
}
