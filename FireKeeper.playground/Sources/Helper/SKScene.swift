import SpriteKit

public extension SKScene {
    override func mouseDown(with event: NSEvent) {
        touchesBegan(with: event)
    }
    override func mouseDragged(with event: NSEvent) {
        touchesMoved(with: event)
    }
    override func mouseUp(with event: NSEvent) {
        touchesEnded(with: event)
    }
}
