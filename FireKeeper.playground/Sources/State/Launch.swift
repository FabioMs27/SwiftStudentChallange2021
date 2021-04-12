import GameplayKit

class Launch: PlayerState {
    var force: CGFloat {
        player.force
    }
    var angle: CGFloat {
        player.launchAngle
    }
    
    override func didEnter(from previousState: GKState?) {
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let xForce = force * sin(angle)
        let yForce = -force * cos(angle)
        player.physicsBody?.applyImpulse(CGVector(dx: xForce, dy: yForce))
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Launch.Type
    }
}
