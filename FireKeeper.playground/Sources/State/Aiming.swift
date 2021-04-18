import GameplayKit

class Aiming: PlayerState {
    
    let alpha: CGFloat = 0.4
    
    override func didEnter(from previousState: GKState?) {
        if let state = previousState,
           !state.isMember(of: Carried.self) {
            slowMotion(duration: 0.5, from: 1, to: 0.1)
        }
        aim.removeAllActions()
        let fadeAction: SKAction = .fadeIn(withDuration: 0.2)
        aim.run(fadeAction)
        let nodeAlpha: SKAction = .fadeAlpha(to: alpha, duration: 0.2)
        scene.initialTouchNode.run(nodeAlpha)
        scene.currentTouchNode.run(nodeAlpha)
    }
    override func willExit(to nextState: GKState) {
        scene.initialTouchNode.removeAllActions()
        scene.currentTouchNode.removeAllActions()
        scene.initialTouchNode.alpha = 0
        scene.currentTouchNode.alpha = 0
        aim.removeAllActions()
        aim.alpha = 0
        endSlowMotion()
        player.endBurning()
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
