//
// Created by soltan on 05/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import  UIKit


extension  UIImage {
    func colorImageByCompletion(completionPercentage: Double = 1, activeColor: UIColor = .primaryColor, backgroundColor: UIColor = .gray) -> UIImage? {
        guard let inputCGIImage = self.cgImage, completionPercentage >= 0, completionPercentage <= 1 else { return nil }
        let colorSpace          = CGColorSpaceCreateDeviceRGB()
        let width               = inputCGIImage.width
        let height              = inputCGIImage.height
        let bytesPerPixel       = 4
        let bitsPerComponent    = 8
        let bytesPerRow         = bytesPerPixel * width
        let bitmapInfo          = RGBA32.bitmapInfo
        let widthBreakpoint     = Int(Double(height) * completionPercentage)

        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
            print("Unable to create context")
            return nil
        }
        context.draw(inputCGIImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let buffer = context.data else {
            print(" unable to get context data")
            return nil
        }

        let pixelBuffer = buffer.bindMemory(to: RGBA32.self, capacity: width * height)

        for row in 0 ..< Int(height) {
            for column in 0..<Int(width) {
                let offset = row * width + column
                if (pixelBuffer[offset].alphaComponent == 0) {
                    continue;
                }
                if (column < widthBreakpoint) {
                    pixelBuffer[offset] = activeColor.rgb()!
                } else {
                    pixelBuffer[offset] = backgroundColor.rgb()!
                }

            }
        }

        let outputCGIImage = context.makeImage()!
        let outputImage = UIImage(cgImage: outputCGIImage, scale: self.scale, orientation: self.imageOrientation)

        return outputImage
    }
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIColor {

    func rgb() -> RGBA32? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            return RGBA32(red:UInt8(iRed), green:UInt8(iGreen), blue:UInt8(iBlue), alpha:UInt8(iAlpha))
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}

struct RGBA32: Equatable {
    private var color: UInt32

    var redComponent: UInt8 {
        return UInt8((color >> 24) & 255)
    }

    var greenComponent: UInt8 {
        return UInt8((color >> 16) & 255)
    }

    var blueComponent: UInt8 {
        return UInt8((color >> 8) & 255)
    }

    var alphaComponent: UInt8 {
        return UInt8((color >> 0) & 255)
    }

    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        let red   = UInt32(red)
        let green = UInt32(green)
        let blue  = UInt32(blue)
        let alpha = UInt32(alpha)
        color = (red << 24) | (green << 16) | (blue << 8) | (alpha << 0)
    }

    static let red     = RGBA32(red: 255, green: 0,   blue: 0,   alpha: 255)
    static let green   = RGBA32(red: 0,   green: 255, blue: 0,   alpha: 255)
    static let blue    = RGBA32(red: 0,   green: 0,   blue: 255, alpha: 255)
    static let white   = RGBA32(red: 255, green: 255, blue: 255, alpha: 255)
    static let black   = RGBA32(red: 0,   green: 0,   blue: 0,   alpha: 255)
    static let magenta = RGBA32(red: 255, green: 0,   blue: 255, alpha: 255)
    static let yellow  = RGBA32(red: 255, green: 255, blue: 0,   alpha: 255)
    static let cyan    = RGBA32(red: 0,   green: 255, blue: 255, alpha: 255)

    static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue

    static func ==(lhs: RGBA32, rhs: RGBA32) -> Bool {
        return lhs.color == rhs.color
    }
}
