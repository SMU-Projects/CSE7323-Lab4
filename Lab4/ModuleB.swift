//
//  ModuleB.swift
//  Lab4
//
//  Created by Will Lacey on 11/3/19.
//  Copyright © 2019 Will Lacey. All rights reserved.
//

import UIKit
import AVFoundation

class ModuleB: UIViewController   {
    
    //MARK: UI Properties
    @IBOutlet weak var label: UILabel!
    
    //MARK: Class Properties
    var filters : [CIFilter]! = nil
    var videoManager:VideoAnalgesic! = nil
    
    let pinchFilterIndex = 2
    let bridge = OpenCVBridge()
    
    //MARK: ViewController Hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = nil
        
        self.videoManager = VideoAnalgesic.sharedInstance
        self.videoManager.setCameraPosition(position: AVCaptureDevice.Position.back)

        
        self.bridge.setTransforms(self.videoManager.transform)
        self.videoManager.setProcessingBlock(newProcessBlock: self.processImage)
        
        
        
        if !videoManager.isRunning{
            videoManager.start()
        }
        
        self.bridge.processType = 1
    
    }
    
    //MARK: Process image output
    func processImage(inputImage:CIImage) -> CIImage{
        
        self.videoManager.turnOnFlashwithLevel(1.0)
        var retImage = inputImage
        
        self.bridge.setImage(retImage,  withBounds: retImage.extent, andContext: self.videoManager.getCIContext())
        
        let value = self.bridge.moduleBFunction()
        
        if value == -1 {
            DispatchQueue.main.async {
                self.label.font = self.label.font.withSize(16)
                self.label.text = "Please Place Your Finger Over The Flashlight\n For 5 Seconds"
            }
        }
        else
        {
            DispatchQueue.main.async {
                self.label.font = self.label.font.withSize(50)
                self.label.text = "\(value) BPS"
            }
        }
        
        retImage = self.bridge.getImage()
        
        return retImage
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.videoManager.isRunning{
            self.videoManager.shutdown()
        }
    }
}

