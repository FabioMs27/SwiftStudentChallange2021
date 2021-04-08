//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = SKScene()
scene.scaleMode = .aspectFill
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
