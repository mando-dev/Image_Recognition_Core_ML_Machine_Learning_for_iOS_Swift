//
//  UIImage+Additions.swift
//  ImageRecognitionCoreML
//
//  Created by Milhouse Tattoos on 12/24/19.
//  Copyright © 2019 www.AlfaData.tech. All rights reserved.
//

import Foundation
//this is how we are goign to access the UI image
import UIKit

//start extending UI image. This is resizing our pics to 299x299
//notice how this function is declared inside the extension UIImage so we can reuse many times
// extension is an instance or an object
extension UIImage {
    
    func resizeTo(size : CGSize) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        //we are already passing in size
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        //now we are getting the resized image back
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        //once we have the resized image back, we can the context for the graphics
        UIGraphicsEndImageContext()
        return resizedImage
            }
        
    // this unction was added by girl from fivver
        func toBuffer() -> CVPixelBuffer? {
             let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
             var pixelBuffer : CVPixelBuffer?
               let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
             guard (status == kCVReturnSuccess) else {
               return nil
             }

             CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
             let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

             let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
             let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

             context?.translateBy(x: 0, y: self.size.height)
             context?.scaleBy(x: 1.0, y: -1.0)

             UIGraphicsPushContext(context!)
             self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
             UIGraphicsPopContext()
             CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

             return pixelBuffer
           }
        
    }
    

