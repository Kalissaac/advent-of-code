//
//  main.swift
//  
//  Puzzle solution
//  Advent of Code 2020
//

import Foundation

let input = Input().daySix

func partOne() -> Int {
    var groupResponses: [[Character]] = []
    
    for responses in input.map({ $0.replacingOccurrences(of: "\n", with: "") }) {
        var questions: [Character] = []
        
        for question in responses {
            if questions.filter({ $0 == question }).count == 0 {
                questions.append(question) // If question doesn't already exist in array, add it
            }
        }
        
        groupResponses.append(questions)
    }
    
    var totalQuestions = 0
    groupResponses.compactMap({ $0.count }).forEach({ totalQuestions += $0 })
    
    return totalQuestions
}

func partTwo() -> Int {
    var groupResponses: [[Character]] = []
    
    for responses in input {
        var questions: [Character] = []
        
        // First collect all questions answered
        for question in responses.replacingOccurrences(of: "\n", with: "") {
            if questions.filter({ $0 == question }).count == 0 {
                questions.append(question)
            }
        }
        
        // Filter the non-answered ones out
        for person in responses.split(separator: "\n") {
            let personQuestions = person.map(Character.init) // All questions that person responded to
            
            questions = questions.filter({ personQuestions.contains($0) }) // Filter out any questions that person did not respond to
        }
        
        groupResponses.append(questions)
    }
    
    var totalQuestions = 0
    groupResponses.compactMap({ $0.count }).forEach({ totalQuestions += $0 })
    
    return totalQuestions
}

print("\(partOne()) total questions for all groups")
print("\(partTwo()) total questions that everyone responded to")
