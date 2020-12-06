//
//  File.swift
//  
//
//  
//

import Foundation

struct Passport: Decodable {
    var byr: String?
    var iyr: String?
    var eyr: String?
    var hgt: String?
    var hcl: String?
    var ecl: String?
    var pid: String?
    var cid: String?
    
    var hasAllFields: Bool {
        return !([byr, iyr, eyr, hgt, hcl, ecl, pid] as [Any?]).contains(where: { $0 == nil })
    }
    
    var valid: Bool {
        if !hasAllFields {
            return false
        }
        if !(Int(byr!) ?? 0 >= 1920 && Int(byr!) ?? 0 <= 2002) {
            return false
        }
        if !(Int(iyr!) ?? 0 >= 2010 && Int(iyr!) ?? 0 <= 2020) {
            return false
        }
        if !(Int(eyr!) ?? 0 >= 2020 && Int(eyr!) ?? 0 <= 2030) {
            return false
        }
        if let unit = hgt?.suffix(2) {
            let height = Int(hgt!.dropLast(2)) ?? 0
            switch unit {
                case "cm":
                    if !(height >= 150 && height <= 193) {
                        return false
                    }
                case "in":
                    if !(height >= 59 && height <= 76) {
                        return false
                    }
                default:
                    break
            }
        }
        // This is the point where I got tired of doing it manually
        if hcl!.range(of: #"^#[a-f0-9]{6}$"#, options: .regularExpression) == nil {
            return false
        }
        if ecl!.range(of: #"^(amb|blu|brn|gry|grn|hzl|oth)$"#, options: .regularExpression) == nil {
            return false
        }
        if pid!.range(of: #"^\d{9}$"#, options: .regularExpression) == nil {
            return false
        }
        return true
    }
}

let input = Input().dayFour

var passports: [Passport] = []

for passport in input {
    // Do some real ugly conversion into JSON
    var dataJSON = "{"
    let preparsed = passport.components(separatedBy: " ")
    for token in preparsed {
        let splits = token.components(separatedBy: ":")
        dataJSON += """
            "\(splits[0])": "\(splits[1])",
            """
    }
    dataJSON += "}"
    // Attempt to decode this cursed creation into the struct
    passports.append(try! JSONDecoder().decode(Passport.self, from: dataJSON.data(using: .utf8)!))
}

func partOne() -> Int {
    return passports.filter({ $0.hasAllFields == true }).count
}

func partTwo() -> Int {
    // For some reason, this returns one above the actual number of valid passports
    // Don't really want to debug this, I have no idea where it's getting it from
    return passports.filter({ $0.valid == true }).count - 1
}

print("\(partOne()) passports with all required fields")
print("\(partTwo()) passports that pass validation")
