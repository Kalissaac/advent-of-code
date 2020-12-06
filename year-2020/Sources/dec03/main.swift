//
//  File.swift
//  
//
//  
//

import Foundation

let input = Input().dayThree

func getTrees(forSlope slope: Int, down: Int) -> Int {
    var horizontalIndex = slope
    var trees = 0
    
    // Skip the inital down amount since we start from top left
    for i in stride(from: down, to: input.count, by: down) {
        let path = input[i]
        
        let pathIndex = path.index(path.startIndex, offsetBy: horizontalIndex % path.count)
        if path[pathIndex] == "#" {
            trees += 1
        }
        
        horizontalIndex += slope
    }
    
    return trees
}

print("Part One: \(getTrees(forSlope: 3, down: 1)) trees in slope")

print("Part Two: \(getTrees(forSlope: 1, down: 1) * getTrees(forSlope: 3, down: 1) * getTrees(forSlope: 5, down: 1) * getTrees(forSlope: 7, down: 1) * getTrees(forSlope: 1, down: 2)) trees in all slopes")
