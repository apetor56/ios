//
//  Vector.swift
//  Tests
//
//  Created by user270821 on 1/21/25.
//

import Foundation

struct Vector : Equatable {
    let x: Double
    let y: Double
    let z: Double

    func length() -> Double {
        return sqrt(x * x + y * y + z * z)
    }

    static func dotProduct(_ v1: Vector, _ v2: Vector) -> Double {
        return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
    }

    static func add(_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(x: v1.x + v2.x, y: v1.y + v2.y, z: v1.z + v2.z)
    }

    static func subtract(_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(x: v1.x - v2.x, y: v1.y - v2.y, z: v1.z - v2.z)
    }

    static func crossProduct(_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(
            x: v1.y * v2.z - v1.z * v2.y,
            y: v1.z * v2.x - v1.x * v2.z,
            z: v1.x * v2.y - v1.y * v2.x
        )
    }
}		
