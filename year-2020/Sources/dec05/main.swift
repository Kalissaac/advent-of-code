//
//  main.swift
//  
//  Puzzle solution
//  Advent of Code 2020
//

import Foundation

struct BoardingPass {
    var binaryInstructions: [String] // First half is row instructions, second half is column instructions
    var row: Int
    var column: Int
    
    var seatID: Int {
        return row * 8 + column
    }
}

let input = Input().dayFive

var boardingPasses: [BoardingPass] = []

func narrowRow(withInstructions: Substring, _ rowRange: inout (ArraySlice<Int>)) -> Int {
    var instructions = withInstructions
    if rowRange.count == 1 {
        return rowRange[rowRange.endIndex - 1] // Element is not at index 0, so we need to find out where it is
    }
    switch instructions.popFirst() {
        case "F":
            rowRange = rowRange.dropLast(rowRange.count / 2) // Front end of array
        case "B":
            rowRange = rowRange.dropFirst(rowRange.count / 2) // Back end of array
        default:
            break
    }
    return narrowRow(withInstructions: instructions, &rowRange)
}

func narrowColumn(withInstructions: Substring, _ columnRange: inout (ArraySlice<Int>)) -> Int {
    var instructions = withInstructions
    if columnRange.count == 1 {
        return columnRange[columnRange.endIndex - 1] // Element is not at index 0, so we need to find out where it is
    }
    switch instructions.popFirst() {
        case "L":
            columnRange = columnRange.dropLast(columnRange.count / 2) // Front end of array
        case "R":
            columnRange = columnRange.dropFirst(columnRange.count / 2) // Back end of array
        default:
            break
    }
    return narrowColumn(withInstructions: instructions, &columnRange)
}

for pass in input {
    if pass.count != 10 { continue }
    
    var rowRange = ArraySlice(0...127)
    let rowInstructions = pass.dropLast(3) // First seven characters
    let row = narrowRow(withInstructions: pass, &rowRange)
    
    var columnRange = ArraySlice(0...7)
    let columnInstructions = pass.suffix(3) // Last three characters
    let column = narrowColumn(withInstructions: pass, &columnRange)
    
    boardingPasses.append(BoardingPass(binaryInstructions: [String(rowInstructions), String(columnInstructions)], row: row, column: column))
}

func partOne() -> Int {
    return boardingPasses.sorted { (a, b) -> Bool in
        a.seatID > b.seatID // Sort high to low
    }[0].seatID
}

func partTwo() -> Int {
    let sortedBoardingPasses = boardingPasses.sorted { (a, b) -> Bool in
        a.seatID < b.seatID // Sort low to high
    }.map { $0.seatID } // And just use seat ID
        
    // All seat IDs are sequential, so just look for the missing seat ID
    var seatIndex = sortedBoardingPasses[0]
    for seat in sortedBoardingPasses.dropFirst() {
        if seat == seatIndex + 1 {
            seatIndex += 1
        } else {
            return seat - 1
        }
    }
    return 0
}

print("\(partOne()) is the highest seat ID")
print("\(partTwo()) is your seat ID")
