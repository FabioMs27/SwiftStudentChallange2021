import Foundation

public enum PhysicsCategory: UInt32 {
    case none    = 0
    case wall    = 1
    case player  = 2
    case powerUp = 4
    case floor   = 8
}
