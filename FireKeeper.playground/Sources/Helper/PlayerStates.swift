import Foundation

public enum PlayerStates {
    case carried
    case collected
    case falling
    case finished
    case launch
    case start
    case aiming
    
    public var classType: AnyClass {
        switch self {
        case .carried:   return Carried.self
        case .collected: return Collected.self
        case .falling:   return Falling.self
        case .finished:  return Finished.self
        case .launch:    return Launch.self
        case .start:     return Start.self
        case .aiming:    return Aiming.self
        }
    }
}
