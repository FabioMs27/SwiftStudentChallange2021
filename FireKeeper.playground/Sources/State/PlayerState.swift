import GameplayKit

class PlayerState: GKState {
    unowned let player: Player
    public init(_ player: Player) {
        self.player = player
    }
}
