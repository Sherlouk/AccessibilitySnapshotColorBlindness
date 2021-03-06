//
// Copyright (c) 2021 James Sherlock
//

import UIKit

struct Matrix {
    let red: [CGFloat]
    let green: [CGFloat]
    let blue: [CGFloat]
    let alpha: [CGFloat]
    
    /// Creates a new RGBA filter matrix describing the different colour transformations.
    ///
    /// Each colour array **MUST** contain exactly five values.
    ///
    /// See https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feColorMatrix for more information
    init(red: [CGFloat], green: [CGFloat], blue: [CGFloat], alpha: [CGFloat]) {
        assert(red.count == 5)
        assert(green.count == 5)
        assert(blue.count == 5)
        assert(alpha.count == 5)
        
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    /// Replaces the pixel indicated by the byteCount with that of the one transformed by this matrix instance.
    func updatePixel(data: inout UnsafeMutablePointer<UInt8>, byteIndex: Int) {
        // R' = r1*R + r2*G + r3*B + r4*A + r5
        // G' = g1*R + g2*G + g3*B + g4*A + g5
        // B' = b1*R + b2*G + b3*B + b4*A + b5
        // A' = a1*R + a2*G + a3*B + a4*A + a5
        
        let oldRed   = CGFloat(data[byteIndex + 0]) / 255
        let oldGreen = CGFloat(data[byteIndex + 1]) / 255
        let oldBlue  = CGFloat(data[byteIndex + 2]) / 255
        let oldAlpha = CGFloat(data[byteIndex + 3]) / 255
        
        let map: ([CGFloat]) -> CGFloat = { multipliers in
            max(min(CGFloat(
                (multipliers[0] * oldRed) +
                    (multipliers[1] * oldGreen) +
                    (multipliers[2] * oldBlue) +
                    (multipliers[3] * oldAlpha) +
                    multipliers[4]
            ), 1), 0) * 255
        }
        
        data[byteIndex + 0] = UInt8(map(red))
        data[byteIndex + 1] = UInt8(map(green))
        data[byteIndex + 2] = UInt8(map(blue))
        data[byteIndex + 3] = UInt8(map(alpha))
    }
}
