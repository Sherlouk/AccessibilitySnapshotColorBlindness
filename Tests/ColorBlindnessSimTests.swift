//
// Copyright (c) 2021 James Sherlock
//

@testable import AccessibilitySnapshotColorBlindness
import SnapshotTesting
import XCTest

final class ColorBlindnessSimTests: XCTestCase {
    func testImages() throws {
        let url = URL(fileURLWithPath: #filePath).deletingLastPathComponent().appendingPathComponent("example.png")
        let image = try UIImage(data: Data(contentsOf: url))!
        
        assertSnapshot(matching: image, as: .image, named: "normal")
        
        MatrixTypes.allCases.forEach {
            assertSnapshot(matching: image, as: .image_colourBlindness(type: $0), named: $0.rawValue)
        }
    }
}
