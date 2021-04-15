import GameplayKit

class Start: PlayerState {
    override func didEnter(from previousState: GKState?) {
        print("Press to start")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is Falling.Type ||
            stateClass is Carried.Type
    }
}
