import Foundation

let inputArrayRaw = Input().dayOne
var inputArray = Array.init(repeating: 0, count: inputArrayRaw.count)

for (i, v) in inputArrayRaw.enumerated() {
    inputArray[i] = Int(v)!
}

func partOne(array: [Int]) -> Int {
    var numA: Int = 0
    var numB: Int = 0
    for i in array {
        for j in array {
            if i + j == 2020 {
                numA = i
                numB = j
                break
            }
        }
        if numA != 0 && numB != 0 {
            break
        }
    }
    return numA * numB
}

func partTwo(array: [Int]) -> Int {
    var numA: Int = 0
    var numB: Int = 0
    var numC: Int = 0
    for i in array {
        for j in array {
            for k in array {
                if i + j + k == 2020 {
                    numA = i
                    numB = j
                    numC = k
                    break
                }
            }
        }
        if numA != 0 && numB != 0 && numC != 0 {
            break
        }
    }
    return numA * numB * numC
}

print("Part One: \(partOne(array: inputArray))")
print("Part Two: \(partTwo(array: inputArray))")
