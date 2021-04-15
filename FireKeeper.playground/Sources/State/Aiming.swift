import GameplayKit

class Aiming: PlayerState {
    
    override func didEnter(from previousState: GKState?) {
        if let state = previousState,
           !state.isMember(of: Carried.self) {
            slowMotion(duration: 0.5, from: 1, to: 0.2)
        }
        aim.removeAllActions()
        let fadeAction: SKAction = .fadeIn(withDuration: 0.2)
        aim.run(fadeAction)
    }
    override func willExit(to nextState: GKState) {
        aim.removeAllActions()
        aim.alpha = 0
        endSlowMotion()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if player.isGrounded {
            player.clampedEnergy -= energyLossrRate
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Launch.Type ||
            stateClass is Carried.Type
    }
}
