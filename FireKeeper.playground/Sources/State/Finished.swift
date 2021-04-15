import GameplayKit

class Finished: PlayerState {
    override func didEnter(from previousState: GKState?) {
        print("Finished the game")
    }
}
