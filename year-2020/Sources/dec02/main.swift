import Foundation

struct Password {
    var policyLength: [Int] = [0, 0]
    var policyChar: String
    var userPassword: String
    var valid: Bool?
    
    init(policyLengthRaw: String, policyCharRaw: String, userPasswordRaw: String) {
        self.policyLength = policyLengthRaw.split(separator: "-").map { Int($0)! }
        self.policyChar = String(policyCharRaw.dropLast())
        self.userPassword = userPasswordRaw
    }
    
    var policyLengthIndex1: String.Index {
        return userPassword.index(userPassword.startIndex, offsetBy: policyLength[0] - 1)
    }
    var policyLengthIndex2: String.Index {
        return userPassword.index(userPassword.startIndex, offsetBy: policyLength[1] - 1)
    }
}

let passwords = Input().dayTwo.map({ (value: String.SubSequence) -> Password in
    let split = value.split(separator: " ")
    return Password(policyLengthRaw: String(split[0]), policyCharRaw: String(split[1]), userPasswordRaw: String(split[2]))
    })

func partOne(_ passwords: [Password]) -> Int {
    var p = passwords
    
    for (i, var password) in p.enumerated() {
        let characterCount = password.userPassword.components(separatedBy: CharacterSet.init(charactersIn: password.policyChar)).count - 1
        if characterCount >= password.policyLength[0] && characterCount <= password.policyLength[1] {
            password.valid = true
            p[i] = password
        } else {
            password.valid = false
            p[i] = password
        }
    }
    
    return p.filter({ $0.valid! == true }).count
}

func partTwo(_ passwords: [Password]) -> Int {
    var p = passwords
     
    for (i, var password) in p.enumerated() {
        var checkA = false
        var checkB = false
    
        
        if password.userPassword[password.policyLengthIndex1] == Character(password.policyChar) {
            checkA = true
        }
        if password.userPassword[password.policyLengthIndex2] == Character(password.policyChar) {
            checkB = true
        }
        
        if (checkA == true && checkB == true) || (checkA == false && checkB == false) {
            password.valid = false
            p[i] = password
        } else {
            password.valid = true
            p[i] = password
        }
    }
    
    return p.filter({ $0.valid! == true }).count
}


print("Valid passwords part one: \(partOne(passwords))")
print("Valid passwords part two: \(partTwo(passwords))")

// MARK: - Input


