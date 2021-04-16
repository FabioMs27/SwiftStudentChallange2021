import GameplayKit

class Collected: PlayerState {
    override func didEnter(from previousState: GKState?) {
        player.physicsBody?.allContactedBodies()
            .map { $0.node as? SKEmitterNode }
            .filter { $0 != nil }
            .forEach {
                collect(fire: $0)
                player.clampedEnergy += PUSettings.fireEnergy
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
        guard let emitter = fire,
              let oldParent = emitter.parent else {
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
        let scaleAction: SKAction = .scale(to: 0, duration: goToCenterDuration)
        let goToCenter: SKAction = .move(to: .zero, duration: goToCenterDuration)
        let finishAnimation: SKAction = .run { [scene] in
            emitter.particleBirthRate = 0
            emitter.move(toParent: oldParent)
            spinningNode.removeAllActions()
            spinningNode.removeFromParent()
            scene.powerUpSpawner.powerUpStack.append(emitter)
            emitter.removeAllActions()
            emitter.removeFromParent()
        }
        let goToCenterGroup: SKAction = .group([scaleAction, goToCenter])
        let goToCenterSequence: SKAction = .sequence([goToCenterGroup, finishAnimation])
        
        let actionSequence: SKAction = .sequence([goToSpinningNodeSequence, goToCenterSequence])
        emitter.run(actionSequence)
    }
}
