/*: Fire Keeper
 # What is it?
 * Story
 
 
 In this project I wanted to make you experience as best as possible (in 3 minutes) the situation I am going through at the moment. I am at an age of struggle, but one that everyone has to go through. I am a young adult. Young enough to be a begginner but not young enough to slack off and be fine with it. Yet most notably, I am fighting to stablish myself as a good father, husband and professional. Since I am in my last year of University, it's the moment I have to fight the most.
 
 I sujest you play the game first before reading this part. In this project you listen to an old man telling you what to do and you have to collect flames so you can become a star and finally "stablish yourself". Here is the thing though. I bet you struggled even  though you heard the old guy, and that's because the game is suposed to be hard. I hope you got to see the end of it though. The thing about learning is that experimenting it for yourself is the best way of leaning something. In my age you constantly listen to elders, but at the end you have to do it yourself. You play as a fire commet to simbolise the flame and passion us young adults have. The flames you collect represent the opportunities available. There are plenty but you still have to do an effort to get them. By launching youself you loose energy, but most importantly, by staying on the floor you let youself be carried. Being carried means you are letting other people do it for you, and the consequence is that you loose your flame. By being carried you will never grow. By becoming a start that means you have stablished youself as an adult.
 
 
 # Tutorial
 * You can only start when the player is at the center of the screen.
 * Aim like with a slingshot.
 * Click anywhere in the screen to become the center of the slingshot.
 * Drag the mouse while clicking to form an angle to where you are going to launch youself to.
 * Release the click to launch yourself to the direction.
 * You can aim in slow motion whiile in the air.
 * Collect enough flames to win.
 * Launch yourself and touch the flames to collect them.
 * if you launch youself you loose energy.
 * Staying in the floor makes you loose energy.
 * The player changes color and strenght based on the energy it has.
 
 */



import PlaygroundSupport
import SpriteKit


let sceneView = SKView(frame: CGRect(origin: .zero, size: Metrics.screenSize))
let scene = GameScene(size: Metrics.screenSize)
scene.scaleMode = .aspectFit
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
