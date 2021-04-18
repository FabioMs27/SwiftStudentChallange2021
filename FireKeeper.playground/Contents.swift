//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit


let sceneView = SKView(frame: CGRect(origin: .zero, size: Metrics.screenSize))
let scene = GameScene(size: Metrics.screenSize)
scene.scaleMode = .aspectFit
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
