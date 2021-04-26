//
// Copyright (c) 2021 James Sherlock
//

@testable import SnapshotTesting
import UIKit

// MARK: - UIImage

public extension Snapshotting where Value == UIImage, Format == UIImage {
    static func image_colourBlindness(type: MatrixTypes) -> Snapshotting {
        return Snapshotting<UIImage, UIImage>.image.pullback { image in
            image.applyFilterMatrix(type)!
        }
    }
}

// MARK: - UIViewController

public extension Snapshotting where Value == UIViewController, Format == UIImage {
    static func image_colourBlindness(
        type: MatrixTypes,
        on config: ViewImageConfig,
        precision: Float = 1,
        size: CGSize? = nil,
        traits: UITraitCollection = .init()
    ) -> Snapshotting {
        return SimplySnapshotting.image(precision: precision).asyncPullback { viewController in
            snapshotView(
                config: size.map { .init(safeArea: config.safeArea, size: $0, traits: config.traits) } ?? config,
                drawHierarchyInKeyWindow: false,
                traits: traits,
                view: viewController.view,
                viewController: viewController
            ).map {
                $0.applyFilterMatrix(type)!
            }
        }
    }
}

// MARK: - UIView

public extension Snapshotting where Value == UIView, Format == UIImage {
    static func image_colourBlindness(
        type: MatrixTypes,
        on config: ViewImageConfig,
        precision: Float = 1,
        size: CGSize? = nil,
        traits: UITraitCollection = .init()
    ) -> Snapshotting {
        return SimplySnapshotting.image(precision: precision).asyncPullback { view in
            snapshotView(
                config: size.map { .init(safeArea: config.safeArea, size: $0, traits: config.traits) } ?? config,
                drawHierarchyInKeyWindow: false,
                traits: traits,
                view: view,
                viewController: .init()
            ).map {
                $0.applyFilterMatrix(type)!
            }
        }
    }
}
