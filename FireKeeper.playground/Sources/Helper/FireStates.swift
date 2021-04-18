import SpriteKit

public enum FireStates {
    public static func getFireSettings(basedOn energy: CGFloat) -> (color: CGColor, birthRate: CGFloat)? {
        switch energy {
        case 0:       return (color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), birthRate: Metrics.defaultFireBirthRate * 0.25)
        case 1...25:  return (color: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), birthRate: Metrics.defaultFireBirthRate * 0.50)
        case 26...50: return (color: Metrics.defaultFireColor, birthRate: Metrics.defaultFireBirthRate)
        case 51...75: return (color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), birthRate: Metrics.defaultFireBirthRate * 1.25)
        case 76...99: return (color: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), birthRate: Metrics.defaultFireBirthRate * 1.5)
        default: return nil
        }
    }
}

