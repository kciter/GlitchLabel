//
//  GlitchLabel.swift
//  GlitchLabel
//
//  Created by LeeSunhyoup on 2016. 4. 22..
//  Copyright © 2016년 Lee Sun-Hyoup. All rights reserved.
//

import UIKit

@IBDesignable
open class GlitchLabel: UILabel {
    @IBInspectable open var amplitudeBase: Double = 2.0
    @IBInspectable open var amplitudeRange: Double = 1.0
    
    @IBInspectable open var glitchAmplitude: Double = 10.0
    @IBInspectable open var glitchThreshold: Double = 0.9
    
    @IBInspectable open var alphaMin: Double = 0.8
    
    @IBInspectable open var glitchEnabled: Bool = true
    @IBInspectable open var drawScanline: Bool = true
    
    open var blendMode: CGBlendMode = .lighten
    
    fileprivate var channel: Int = 0
    fileprivate var amplitude: Double = 2.5
    fileprivate var phase: Double = 0.9
    fileprivate var phaseStep: Double = 0.05
    fileprivate var globalAlpha: Double = 0.8
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setTimer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTimer()
    }
    
    override open func drawText(in rect: CGRect) {
        if !glitchEnabled {
            super.drawText(in: rect)
            return
        }
        
        var x0 = CGFloat(amplitude * sin((M_PI * 2.0) * phase))
        
        if random() >= glitchThreshold {
            x0 *= CGFloat(glitchAmplitude)
        }
        
        let x1 = CGFloat(Int(bounds.origin.x))
        let x2 = x1 + x0
        let x3 = x1 - x0
        
        globalAlpha = alphaMin + ((1 - alphaMin) * random())
        
        var channelsImage: UIImage?
        switch channel {
        case 0:
            channelsImage = getChannelsImage(x1, x2: x2, x3: x3)
        case 1:
            channelsImage = getChannelsImage(x2, x2: x3, x3: x1)
        case 2:
            channelsImage = getChannelsImage(x3, x2: x1, x3: x2)
        default:
            print("ERROR")
        }
        
        channelsImage?.draw(in: bounds)
        
        if let channelsImage = channelsImage , drawScanline {
            getScanlineImage(channelsImage).draw(in: bounds)
            if floor(random() * 2) > 1 {
                getScanlineImage(channelsImage).draw(in: bounds)
            }
        }
    }
    
    fileprivate func getChannelsImage(_ x1: CGFloat, x2: CGFloat, x3: CGFloat) -> UIImage {
        let redImage = getRedImage(bounds)
        let greenImage = getGreenImage(bounds)
        let blueImage = getBlueImage(bounds)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        redImage.draw(in: bounds + CGRect(x: x1, y: 0, width: 0, height: 0),
                            blendMode: blendMode,
                            alpha: CGFloat(globalAlpha))
        greenImage.draw(in: bounds + CGRect(x: x2, y: 0, width: 0, height: 0),
                              blendMode: blendMode,
                              alpha: CGFloat(globalAlpha))
        blueImage.draw(in: bounds + CGRect(x: x3, y: 0, width: 0, height: 0),
                             blendMode: blendMode,
                             alpha: CGFloat(globalAlpha))
        let channelsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return channelsImage!
    }
    
    fileprivate func getScanlineImage(_ channelsImage: UIImage) -> UIImage {
        let y = bounds.size.height * CGFloat(random())
        let y2 = bounds.size.height * CGFloat(random())
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        
        
        let provider: CGDataProvider = channelsImage.cgImage!.dataProvider!
        let data: Data = provider.data! as Data
        let bytes = (data as NSData).bytes
        let bytePointer = bytes.assumingMemoryBound(to: UInt8.self)
        
        for col in 0 ..< Int(bounds.size.width) {
            let offset = 4*(Int(y) * Int(bounds.size.width) + col)
            let alpha = bytePointer[offset]
            let red = bytePointer[offset+1]
            let green = bytePointer[offset+2]
            let blue = bytePointer[offset+3]
            context?.setFillColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
            context?.fill(CGRect(x: CGFloat(col), y: y2, width: 1, height: 0.5))
        }
        
        let scanlineImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scanlineImage!
    }
    
    fileprivate func getRedImage(_ rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        text?.draw(in: rect, withAttributes: [
            NSFontAttributeName: UIFont.init(name: font.fontName, size: font.pointSize)!,
            NSForegroundColorAttributeName: UIColor.red
            ])
        
        let redImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return redImage
    }
    
    fileprivate func getGreenImage(_ rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        text?.draw(in: rect, withAttributes: [
            NSFontAttributeName: UIFont.init(name: font.fontName, size: font.pointSize)!,
            NSForegroundColorAttributeName: UIColor.green
            ])
        let greenImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return greenImage
    }
    
    fileprivate func getBlueImage(_ rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        text?.draw(in: rect, withAttributes: [
            NSFontAttributeName: UIFont.init(name: font.fontName, size: font.pointSize)!,
            NSForegroundColorAttributeName: UIColor.blue
            ])
        
        let blueImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return blueImage
    }
    
    @objc fileprivate func tick() {
        phase += phaseStep
        if phase > 1 {
            phase = 0
            channel = (channel == 2) ? 0 : channel + 1
            amplitude = amplitudeBase + (amplitudeRange * random())
        }
        
        setNeedsDisplay()
    }
    
    fileprivate func setTimer() {
        let timer = Timer(timeInterval: 1/30.0,
                           target: self,
                           selector: #selector(GlitchLabel.tick),
                           userInfo: nil,
                           repeats: true)
        
        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    fileprivate func random() -> Double {
        return (Double(arc4random()) / Double(UINT32_MAX))
    }
}

func +(rect1: CGRect, rect2: CGRect) -> CGRect {
    return CGRect(x: rect1.origin.x + rect2.origin.x,
                      y: rect1.origin.y + rect2.origin.y,
                      width: rect1.size.width + rect2.size.width,
                      height: rect1.size.height + rect2.size.height)
}
func +(size1: CGSize, size2: CGSize) -> CGSize {
    return CGSize(width: size1.width + size2.width,
                      height: size1.height + size2.height)
}
