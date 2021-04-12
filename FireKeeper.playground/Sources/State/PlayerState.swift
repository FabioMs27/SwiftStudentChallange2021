import GameplayKit

class PlayerState: GKState {
    unowned let player: Player
    public init(player: Player) {
        self.player = player
    }
}
