import GameplayKit

class Finished: PlayerState {
    override func didEnter(from previousState: GKState?) {
        MusicManager.shared.playAudio2()
        finishGame()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        false
    }
}

extension Finished {
    func finishGame() {
        scene.powerUpSpawner.removeAllActions()
        player.physicsBody = nil
        let goToCenter: SKAction = .move(to: .zero, duration: 3)
        let goUp: SKAction = .move(to: CGPoint(x: 0, y: Metrics.screenSize.height), duration: 1)
        let becomeStar: SKAction = .run { [player] in
            player.fireEmitter.targetNode = nil
            player.fireEmitter.isHidden = true
            player.finalStar.isHidden = false
        }
        let waitToGoDown: SKAction = .wait(forDuration: 2)
        let rotate: SKAction = .rotate(byAngle: .pi, duration: 1)
        let repeatRotation: SKAction = .repeatForever(rotate)
        let goDown: SKAction = .move(to: CGPoint(x: 0, y: -Metrics.screenSize.height), duration: 10)
        let goDownGroup: SKAction = .group([repeatRotation, goDown])
        
        
        player.run(.sequence([
            goToCenter,
            goUp,
            waitToGoDown,
            becomeStar,
            goDownGroup
        ]))
    }
}
