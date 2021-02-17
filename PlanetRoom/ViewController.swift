//
//  ViewController.swift
//  PlanetRoom
//
//  Created by Emmanuel Cuevas on 09/02/21.
//

import UIKit
import SceneKit
import ARKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var solarSystem = SolarSystem()
    var planetName:String = ""
    let wikipediaURL = "https://en.wikipedia.org/w/api.php"
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        This line helps to show the points in the view
//        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        updatePlanet()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - Buttons
    
    @IBAction func prevPresssed(_ sender: UIButton) {
        solarSystem.prevPlanet()
        updatePlanet()
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        solarSystem.nextPlanet()
        updatePlanet()
    }
    
//    MARK: - Renderer
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor{
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y:0, z:planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            let gridMaterial = SCNMaterial()
            plane.materials = [gridMaterial]
            planeNode.geometry = plane
//            node.addChildNode(planeNode)
        }else{
            return
        }
    }
    
    func updatePlanet(){
        
        let sphere = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: solarSystem.getPlanetImage())
        sphere.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(0, 0.1, -0.5)
        node.geometry = sphere
        sceneView.scene.rootNode.addChildNode(node)
        
        solarSystem.getPlanetImage()
        
        planetNameLabel.text = solarSystem.getPlanetName()
        
        requestInfo(wordSearched: solarSystem.getPlanetName())
        
    }
    
    func requestInfo(wordSearched: String){

            
            let parameters: [String:String] = [
                "format" : "json",
                "action" : "query",
                "prop" : "extracts|pageimages",
                "exintro" : "",
                "explaintext" : "",
                "titles" : wordSearched,
                "indexpageids" : "",
                "redirects" : "1",
                "pithumbsize": "500"
            ]
            
            Alamofire.request(wikipediaURL, method: .get, parameters: parameters).responseJSON {(response) in
                if response.result.isSuccess{
                    print("Got the Wikipedia info")
                    print(response)
                    print("~~~~~~~~~~~~")
                    
                    let wordJSON: JSON = JSON(response.result.value!)
                    
                    let pageid = wordJSON["query"]["pageids"][0].stringValue
                    
                    let planetResume = wordJSON["query"]["pages"][pageid]["extract"].stringValue
                    
                    self.planetDescription.text = planetResume
                    
                    
                }
            }
        }
    

}
