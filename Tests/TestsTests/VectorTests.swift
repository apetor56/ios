//
//  VectorTests.swift
//  Tests
//
//  Created by user270821 on 1/21/25.
//

import XCTest
@testable import Tests

class VectorOperationsTests: XCTestCase {

    func testLength() {
        XCTAssertEqual(Vector(x: 3, y: 4, z: 0).length(), 5.0, accuracy: 0.001)
        XCTAssertEqual(Vector(x: 1, y: 2, z: 2).length(), 3.0, accuracy: 0.001)
        XCTAssertEqual(Vector(x: 0, y: 0, z: 0).length(), 0.0, accuracy: 0.001)
        XCTAssertEqual(Vector(x: -3, y: -4, z: 0).length(), 5.0, accuracy: 0.001)
        XCTAssertEqual(Vector(x: 1, y: 1, z: 1).length(), sqrt(3), accuracy: 0.001)
        XCTAssertEqual(Vector(x: -7, y: -24, z: 0).length(), 25.0, accuracy: 0.001)
    }

    func testDotProduct() {
        XCTAssertEqual(Vector.dotProduct(Vector(x: 1, y: 2, z: 3), Vector(x: 4, y: -5, z: 6)), 12.0, accuracy: 0.001)
        XCTAssertEqual(Vector.dotProduct(Vector(x: 0, y: 0, z: 0), Vector(x: 4, y: -5, z: 6)), 0.0, accuracy: 0.001)
        XCTAssertEqual(Vector.dotProduct(Vector(x: 1, y: 0, z: 0), Vector(x: 0, y: 1, z: 0)), 0.0, accuracy: 0.001)
        XCTAssertEqual(Vector.dotProduct(Vector(x: 1, y: 1, z: 1), Vector(x: 1, y: 1, z: 1)), 3.0, accuracy: 0.001)
        XCTAssertEqual(Vector.dotProduct(Vector(x: -1, y: -1, z: -1), Vector(x: 1, y: 1, z: 1)), -3.0, accuracy: 0.001)
        XCTAssertEqual(Vector.dotProduct(Vector(x: 2, y: 3, z: 4), Vector(x: 5, y: 6, z: 7)), 56.0, accuracy: 0.001)
    }

    func testAddition() {
        XCTAssertEqual(Vector.add(Vector(x: 1, y: 2, z: 3), Vector(x: 4, y: -5, z: 6)), Vector(x: 5, y: -3, z: 9))
        XCTAssertEqual(Vector.add(Vector(x: 0, y: 0, z: 0), Vector(x: 4, y: -5, z: 6)), Vector(x: 4, y: -5, z: 6))
        XCTAssertEqual(Vector.add(Vector(x: 1, y: 1, z: 1), Vector(x: -1, y: -1, z: -1)), Vector(x: 0, y: 0, z: 0))
        XCTAssertEqual(Vector.add(Vector(x: 3, y: 2, z: 1), Vector(x: 0, y: 0, z: 0)), Vector(x: 3, y: 2, z: 1))
        XCTAssertEqual(Vector.add(Vector(x: -1, y: -1, z: -1), Vector(x: -1, y: -1, z: -1)), Vector(x: -2, y: -2, z: -2))
        XCTAssertEqual(Vector.add(Vector(x: 7, y: 8, z: 9), Vector(x: 1, y: 2, z: 3)), Vector(x: 8, y: 10, z: 12))
    }

    func testSubtraction() {
        XCTAssertEqual(Vector.subtract(Vector(x: 4, y: 5, z: 6), Vector(x: 1, y: 2, z: 3)), Vector(x: 3, y: 3, z: 3))
        XCTAssertEqual(Vector.subtract(Vector(x: 0, y: 0, z: 0), Vector(x: 4, y: 5, z: 6)), Vector(x: -4, y: -5, z: -6))
        XCTAssertEqual(Vector.subtract(Vector(x: 1, y: 1, z: 1), Vector(x: 1, y: 1, z: 1)), Vector(x: 0, y: 0, z: 0))
        XCTAssertEqual(Vector.subtract(Vector(x: 5, y: 5, z: 5), Vector(x: 0, y: 0, z: 0)), Vector(x: 5, y: 5, z: 5))
        XCTAssertEqual(Vector.subtract(Vector(x: -1, y: -1, z: -1), Vector(x: -1, y: -1, z: -1)), Vector(x: 0, y: 0, z: 0))
        XCTAssertEqual(Vector.subtract(Vector(x: 10, y: 10, z: 10), Vector(x: 5, y: 5, z: 5)), Vector(x: 5, y: 5, z: 5))
    }

    func testCrossProduct() {
        XCTAssertEqual(Vector.crossProduct(Vector(x: 1, y: 0, z: 0), Vector(x: 0, y: 1, z: 0)), Vector(x: 0, y: 0, z: 1))
        XCTAssertEqual(Vector.crossProduct(Vector(x: 0, y: 1, z: 0), Vector(x: 0, y: 0, z: 1)), Vector(x: 1, y: 0, z: 0))
        XCTAssertEqual(Vector.crossProduct(Vector(x: 0, y: 0, z: 1), Vector(x: 1, y: 0, z: 0)), Vector(x: 0, y: 1, z: 0))
        XCTAssertEqual(Vector.crossProduct(Vector(x: 1, y: 1, z: 1), Vector(x: -1, y: -1, z: -1)), Vector(x: 0, y: 0, z: 0))
        XCTAssertEqual(Vector.crossProduct(Vector(x: 1, y: 2, z: 3), Vector(x: 4, y: 5, z: 6)), Vector(x: -3, y: 6, z: -3))
        XCTAssertEqual(Vector.crossProduct(Vector(x: 2, y: 3, z: 4), Vector(x: 5, y: 6, z: 7)), Vector(x: -3, y: 6, z: -3))
    }
}
