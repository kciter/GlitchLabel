//
//  GlitchLabel.swift
//  GlitchLabel
//
//  Created by LeeSunhyoup on 2016. 4. 22..
//  Copyright © 2016년 Lee Sun-Hyoup. All rights reserved.
//

import UIKit

@IBDesignable
public class GlitchLabel: UILabel {
    @IBInspectable public var amplitudeBase: Double = 2.0
    @IBInspectable public var amplitudeRange: Double = 1.0
    
    @IBInspectable public var glitchAmplitude: Double = 10.0
    @IBInspectable public var glitchThreshold: Double = 0.9
    
    @IBInspectable public var alphaMin: Double = 0.8
    
    @IBInspectable public var glitchEnabled: Bool = true
    @IBInspectable public var drawScanline: Bool = true
    
    public var blendMode: CGBlendMode = .Lighten
    
    private var channel: Int = 0
    private var amplitude: Double = 2.5
    private var phase: Double = 0.9
    private var phaseStep: Double = 0.05
    private var globalAlpha: Double = 0.8
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setTimer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTimer()
    }
    
    override public func drawTextInRect(rect: CGRect) {
        if !glitchEnabled {
            super.drawTextInRect(rect)
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
        
        channelsImage?.drawInRect(bounds)
        
        if let channelsImage = channelsImage where drawScanline {
            getScanlineImage(channelsImage).drawInRect(bounds)
            if floor(random() * 2) > 1 {
                getScanlineImage(channelsImage).drawInRect(bounds)
            }
        }
    }
    
    private func getChannelsImage(x1: CGFloat, x2: CGFloat, x3: CGFloat) -> UIImage {
        let redImage = getRedImage(bounds)
        let greenImage = getGreenImage(bounds)
        let blueImage = getBlueImage(bounds)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        redImage.drawInRect(bounds + CGRectMake(x1, 0, 0, 0),
                            blendMode: blendMode,
                            alpha: CGFloat(globalAlpha))
        greenImage.drawInRect(bounds + CGRectMake(x2, 0, 0, 0),
                              blendMode: blendMode,
                              alpha: CGFloat(globalAlpha))
        blueImage.drawInRect(bounds + CGRectMake(x3, 0, 0, 0),
                             blendMode: blendMode,
                             alpha: CGFloat(globalAlpha))
        let channelsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return channelsImage
    }
    
    private func getScanlineImage(channelsImage: UIImage) -> UIImage {
        let y = bounds.size.height * CGFloat(random())
        let y2 = bounds.size.height * CGFloat(random())
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        
        
        let provider: CGDataProviderRef = CGImageGetDataProvider(channelsImage.CGImage)!
        let data: NSData = CGDataProviderCopyData(provider)!
        let bytes = data.bytes
        let bytePointer = UnsafePointer<UInt8>(bytes)
        
        for col in 0 ..< Int(bounds.size.width) {
            let offset = 4*(Int(y) * Int(bounds.size.width) + col)
            let alpha = bytePointer[offset]
            let red = bytePointer[offset+1]
            let green = bytePointer[offset+2]
            let blue = bytePointer[offset+3]
            CGContextSetRGBFillColor(context, CGFloat(red), CGFloat(green), CGFloat(blue), CGFloat(alpha))
            CGContextFillRect(context, CGRectMake(CGFloat(col), y2, 1, 0.5))
        }
        
        let scanlineImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scanlineImage
    }
    
    private func getRedImage(rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        text?.drawInRect(rect, withAttributes: [
            NSFontAttributeName: UIFont.init(name: font.fontName, size: font.pointSize)!,
            NSForegroundColorAttributeName: UIColor.redColor()
            ])
        
        let redImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return redImage
    }
    
    private func getGreenImage(rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        text?.drawInRect(rect, withAttributes: [
            NSFontAttributeName: UIFont.init(name: font.fontName, size: font.pointSize)!,
            NSForegroundColorAttributeName: UIColor.greenColor()
            ])
        let greenImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return greenImage
    }
    
    private func getBlueImage(rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        text?.drawInRect(rect, withAttributes: [
            NSFontAttributeName: UIFont.init(name: font.fontName, size: font.pointSize)!,
            NSForegroundColorAttributeName: UIColor.blueColor()
            ])
        
        let blueImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return blueImage
    }
    
    @objc private func tick() {
        phase += phaseStep
        if phase > 1 {
            phase = 0
            channel = (channel == 2) ? 0 : channel + 1
            amplitude = amplitudeBase + (amplitudeRange * random())
        }
        
        setNeedsDisplay()
    }
    
    private func setTimer() {
        let timer = NSTimer(timeInterval: 1/30.0,
                           target: self,
                           selector: #selector(GlitchLabel.tick),
                           userInfo: nil,
                           repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    
    private func random() -> Double {
        return (Double(arc4random()) / Double(UINT32_MAX))
    }
}

func +(rect1: CGRect, rect2: CGRect) -> CGRect {
    return CGRectMake(rect1.origin.x + rect2.origin.x,
                      rect1.origin.y + rect2.origin.y,
                      rect1.size.width + rect2.size.width,
                      rect1.size.height + rect2.size.height)
}
func +(size1: CGSize, size2: CGSize) -> CGSize {
    return CGSizeMake(size1.width + size2.width,
                      size1.height + size2.height)
}