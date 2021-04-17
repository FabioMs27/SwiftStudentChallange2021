import GameplayKit

class Launch: PlayerState {
    public lazy var launchEmitter: SKEmitterNode = { [player] in
        guard let emitter = SKEmitterNode(fileNamed: "Emitters/Jump.sks") else {
            fatalError("Couldn't load!")
        }
        emitter.targetNode = player.parent
        player.addChild(emitter)
        return emitter
    }()
    
    var force: CGFloat {
        player.force
    }
    var angle: CGFloat {
        player.launchAngle
    }
    
    let launchCoolDown: Double = 1
        
    override func didEnter(from previousState: GKState?) {
        if player.energy < player.launchEnergy {
            player.enter(state: .falling)
            return
        }
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let xForce = force * sin(angle)
        let yForce = -force * cos(angle)
        player.physicsBody?.applyImpulse(CGVector(dx: xForce, dy: yForce))
        player.energy -= player.launchEnergy
        launchEmitter.particleColor = player.fireEmitter.particleColor
        launchEmitter.resetSimulation()
        let waitForLaunch: SKAction = .wait(forDuration: launchCoolDown)
        player.run(waitForLaunch) { [player] in
            player.enter(state: .falling)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Falling.Type ||
            stateClass is Collected.Type ||
            stateClass is Aiming.Type
    }
}
