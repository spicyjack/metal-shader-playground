//: A SpriteKit based Playground

import PlaygroundSupport
import SceneKit

class GameScene: SCNScene {

    override init() {
        
        super.init()
        
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        let ambientLight = SCNLight()
        let lightNode = SCNNode()
        let directLight = SCNLight()
        
//        camera.xFov = 60
//        camera.yFov = 60
        camera.fieldOfView = 60
        
        ambientLight.type = SCNLight.LightType.ambient
        let ambiTint: CGFloat = 0.45
        ambientLight.color = NSColor(red: ambiTint, green: ambiTint, blue: ambiTint, alpha: 1.0)
        
        cameraNode.camera = camera
        cameraNode.light = ambientLight
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 45)
        
        /*
         // Camera constraints
         let cameraConstraint = SCNLookAtConstraint(target: field) // self.cubeNode
         cameraConstraint.isGimbalLockEnabled = true
         self.cameraNode.constraints = [cameraConstraint]
         */
        
        let directTint: CGFloat = 0.83
        directLight.type = SCNLight.LightType.directional // .spot // .omni // .directional
        directLight.color = NSColor(red: directTint, green: directTint, blue: directTint, alpha: 1.0)
        directLight.castsShadow = true
        directLight.zNear = 0
        directLight.zFar = 40
        directLight.orthographicScale = 20
        
        lightNode.light = directLight
        lightNode.position = SCNVector3(x: 0, y: 0, z: 25)
        lightNode.orientation = SCNQuaternion(x: -0.32, y: 0.0, z: 1.0, w: 0.76)
        
        self.rootNode.addChildNode(cameraNode)
        self.rootNode.addChildNode(lightNode)
        
        /////
        
        let back = SCNBox(width: 50, height: 50, length: 1, chamferRadius: 0)
        back.firstMaterial?.diffuse.contents = NSColor(calibratedRed: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        let backNode = SCNNode(geometry: back)
        backNode.position = SCNVector3(0,0,0)
        self.rootNode.addChildNode(backNode)
        

        //// Object
        let object = SCNNode()
        
        let box = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0)
        box.firstMaterial?.diffuse.contents = NSColor(calibratedRed: 0.8, green: 0.1, blue: 0.3, alpha: 1)
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(0,0,15)
        
        let plate = SCNBox(width: 13, height: 13, length: 2, chamferRadius: 0)
        plate.firstMaterial?.diffuse.contents = NSColor(calibratedRed: 0.0, green: 0.5, blue: 0.9, alpha: 1)
        let plateNode = SCNNode(geometry: plate)
        plateNode.position = SCNVector3(0,0,10)

        let stick = SCNBox(width: 2, height: 15, length: 2, chamferRadius: 0)
        stick.firstMaterial?.diffuse.contents = NSColor(calibratedRed: 1.0, green: 0.9, blue: 0.0, alpha: 1)
        let stickNode = SCNNode(geometry: stick)
        stickNode.position = SCNVector3(0,0,20)

        object.addChildNode(boxNode)
        object.addChildNode(plateNode)
        object.addChildNode(stickNode)
        
        self.rootNode.addChildNode(object)
        
        let spin = CABasicAnimation(keyPath: "rotation")
        // Use from-to to explicitly make a full rotation around z
        spin.fromValue = SCNVector4(x: 0, y: 0, z: 1, w: 0)
        spin.toValue = SCNVector4(x: 0.3, y: 1, z: 1, w: CGFloat(2 * Double.pi))
        spin.duration = 3
        spin.repeatCount = .infinity
        object.addAnimation(spin, forKey: "spin around")
        
        
        // Add Glow
        object.categoryBitMask = 2
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SCNView(frame: CGRect(x:0 , y:0, width: 320, height: 320))
sceneView.backgroundColor = NSColor.black

let scene = GameScene()
// Present the scene
sceneView.scene = scene

//if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
//    if let dict = NSDictionary(contentsOfFile: path)  {
//        let dict2 = dict as! [String : AnyObject]
//        let technique = SCNTechnique(dictionary: dict2)
//        // Gives stutter
////        sceneView.technique = technique
//    }
//}


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
