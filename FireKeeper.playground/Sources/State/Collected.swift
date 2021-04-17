import GameplayKit

class Collected: PlayerState {
    override func didEnter(from previousState: GKState?) {
        player.physicsBody?.allContactedBodies()
            .map { $0.node as? SKEmitterNode }
            .filter { $0 != nil }
            .forEach {
                collect(fire: $0)
            }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Aiming.Type ||
            stateClass is Finished.Type ||
            stateClass is Falling.Type ||
            stateClass is Carried.Type
    }
}

extension Collected {
    func collect(fire: SKEmitterNode?) {
        guard let emitter = fire else {
            return
        }
        emitter.physicsBody = nil
        //Settings
        let goToCenterDuration: Double = 2
        let goToSpinningPosDuration: Double = 0.2
        let spinSpeed: Double = 0.2
        
        //SpinningNode
        let spinningNode = SKNode()
        player.addChild(spinningNode)
        emitter.move(toParent: spinningNode)
        emitter.targetNode = player.parent
        emitter.removeAllActions()
        
        //Node will spin to make emitter spin
        let spinAction: SKAction = .rotate(byAngle: .pi, duration: spinSpeed)
        spinAction.timingMode = .easeOut
        let spinForever: SKAction = .repeatForever(spinAction)
        
        //Emitter will go to the spinning position
        let spinningNodePos = CGPoint(x: 0, y: -100)
        let goToSpinningNode: SKAction = .move(
            to: spinningNodePos,
            duration: goToSpinningPosDuration
        )
        goToSpinningNode.timingMode = .easeOut
        let enterSpinningNode: SKAction = .run {
            spinningNode.run(spinForever)
        }
        let goToSpinningNodeSequence: SKAction = .sequence([goToSpinningNode, enterSpinningNode])
        
        //Emitter will go to center of the player while spinning and shrinking
        let goToCenter: SKAction = .move(to: .zero, duration: goToCenterDuration)
        let finishAnimation: SKAction = .run { [player] in
            player.clampedEnergy += PUSettings.fireEnergy
            emitter.particleBirthRate = 0
            //TO-DO: Burst from collecting
        }
        let waitForParticlesToEnd: SKAction = .wait(forDuration: TimeInterval(emitter.particleLifetime))
        let endEmitter: SKAction = .run { [scene] in
            emitter.targetNode = nil
            emitter.removeFromParent()
            emitter.removeAllActions()
            scene.powerUpSpawner.powerUpStack.append(emitter)
            spinningNode.removeAllActions()
            spinningNode.removeFromParent()
        }
        let goToCenterSequence: SKAction = .sequence([goToCenter,
                                                      finishAnimation,
                                                      waitForParticlesToEnd,
                                                      endEmitter])
        
        let actionSequence: SKAction = .sequence([goToSpinningNodeSequence, goToCenterSequence])
        emitter.run(actionSequence)
    }
}
