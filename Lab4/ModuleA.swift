//
//  ModuleB.swift
//  Lab4
//
//  Created by Will Lacey on 11/3/19.
//  Copyright © 2019 Will Lacey. All rights reserved.
//

import UIKit
import AVFoundation

class ModuleA: UIViewController   {
    
    //MARK: UI Properties
    @IBOutlet weak var button: UIButton!
    
    //MARK: Class Properties
    var filters : [CIFilter]! = nil
    var videoManager:VideoAnalgesic! = nil
    var detector:CIDetector! = nil
    
    let pinchFilterIndex = 2
    let bridge = OpenCVBridge()
    
    //MARK: ViewController Hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = nil
        
        self.videoManager = VideoAnalgesic.sharedInstance
        self.videoManager.setCameraPosition(position: AVCaptureDevice.Position.front)
        
        let optsDetector = [CIDetectorAccuracy:CIDetectorAccuracyHigh, CIDetectorTracking:true] as [String : Any]
        
        // setup a face detector in swift
        self.detector = CIDetector(ofType: CIDetectorTypeFace,
                                  context: self.videoManager.getCIContext(), // perform on the GPU if possible
                                  options: optsDetector)
        
        
        self.bridge.setTransforms(self.videoManager.transform)
        self.videoManager.setProcessingBlock(newProcessBlock: self.processImage)
        
        
        
        if !videoManager.isRunning{
            videoManager.start()
        }
        
        self.bridge.processType = 1
    
    }
    
    //MARK: Process image output
    func processImage(inputImage:CIImage) -> CIImage{
        
        // detect faces
        let faces = getFaces(img: inputImage)
        
        // if no faces, just return original image
        if faces.count == 0 { return inputImage }
        
        var retImage = inputImage
        
        for face in faces {
            //HINT: you can also send in the bounds of the face to ONLY process the face in OpenCV
            // or any bounds to only process a certain bounding region in OpenCV
            self.bridge.setImage(retImage,  withBounds: retImage.extent, andContext: self.videoManager.getCIContext())
            self.bridge.moduleAFunction(face)
            retImage = self.bridge.getImage()
        }
        return retImage
    }
    
    func getFaces(img:CIImage) -> [CIFaceFeature]{
        // this ungodly mess makes sure the image is the correct orientation
//        let optsFace = [CIDetectorImageOrientation:self.videoManager.ciOrientation]
        
        let optsFace = [CIDetectorImageOrientation:self.videoManager.ciOrientation, CIDetectorSmile:true, CIDetectorEyeBlink:true] as [String : Any]
        
        // get Face Features
        return self.detector.features(in: img, options: optsFace) as! [CIFaceFeature]
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.videoManager.toggleCameraPosition()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.videoManager.isRunning{
            self.videoManager.shutdown()
        }
    }
}

