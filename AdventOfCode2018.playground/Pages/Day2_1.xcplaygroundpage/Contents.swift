//: [Home](Main)

/*:
 ## Day 2 Part 1
 To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing exactly two of any letter and then separately counting those with exactly three of any letter. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

 For example, if you see the following box IDs:

 - `abcdef` contains no letters that appear exactly two or three times. `( 2 Letters: 0, 3 Letters: 0)`
 - `bababc` contains two a and three b, so it counts for both. `( 2 Letters: 1, 3 Letters: 1)`
 - `abbcde` contains two b, but no letter appears exactly three times. `( 2 Letters: 2, 3 Letters: 1)`
 - `abcccd` contains three c, but no letter appears exactly two times. `( 2 Letters: 2, 3 Letters: 2)`
 - `aabcdd` contains two a and two d, but it only counts once. `( 2 Letters: 3, 3 Letters: 2)`
 - `abcdee` contains two e. `( 2 Letters: 4, 3 Letters: 2)`
 - `ababab` contains three a and three b, but it only counts once. `( 2 Letters: 4, 3 Letters: 4)`

 Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of  `4 * 3 = 12.`

 What is the checksum for your list of box IDs?
 */

import Foundation

extension Int {
    static func initFrom(bool val: Bool) -> Int {
        return val ? 1 : 0
    }
}

func findOccurences(input: String) -> (two: Bool, three: Bool) {
    let counts = input.reduce([Character: Int]()) { res, val in
        var new = res
        if let count = new[val] {
            new[val] = count + 1
        } else {
            new[val] = 1
        }
        return new
    }
    return counts.reduce((two: false, three: false)) { res, val in
        if val.value == 2 {
            return (two: true, three: res.three)
        }
        if val.value == 3 {
            return (two: res.two, three: true)
        }
        return res
    }
}

func getChecksum(input: [(two: Bool, three: Bool)]) -> Int {
    let vals = input
        .reduce((0,0)) { res, val in
            return (res.0 + Int.initFrom(bool: val.two), res.1 + Int.initFrom(bool: val.three))
        }
    return vals.0 * vals.1
}

func day2_1(with data: String) -> Int {
    let values = data
        .split(separator: "\n")
        .map { findOccurences(input: String($0)) }
    return getChecksum(input: values)
}

//: Testing Occurences Function

let occurencesTestdata = [
    (values: "abcdef", res: (two: false, three: false)),
    (values: "bababc", res: (two: true, three: true)),
    (values: "abbcde", res: (two: true, three: false)),
    (values: "abcccd", res: (two: false, three: true)),
    (values: "aabcdd", res: (two: true, three: false)),
    (values: "abcdee", res: (two: true, three: false)),
    (values: "ababab", res: (two: false, three: true))
]

occurencesTestdata.enumerated().forEach { args in
    let (idx, testData) = args
    print("Day2_1 Occurences Test \(idx): \(findOccurences(input: testData.values) == testData.res)")
}

//: Testing Checksum Function

let checksumTestdata = [
    (values: [(two: true, three: true)], res: 1),
    (values: [(two: false, three: false)], res: 0),
    (values: [(two: true, three: false)], res: 0),
    (values: [(two: false, three: true)], res: 0),
    (values: [
        (two: true, three: false),
        (two: true, three: false),
        ],
     res: 0),
    (values: [
        (two: false, three: true),
        (two: false, three: true),
        ],
     res: 0),
    (values: [
        (two: true, three: true),
        (two: true, three: false),
        ],
     res: 2),
    (values: [
        (two: false, three: true),
        (two: true, three: true),
        ],
     res: 2),
    (values: [
        (two: true, three: true),
        (two: true, three: true),
        ],
     res: 4),
    (values: [
        (two: false, three: false),
        (two: true, three: true),
        (two: true, three: false),
        (two: false, three: true),
        (two: true, three: false),
        (two: true, three: false),
        (two: false, three: true)
        ],
     res: 12),
]

checksumTestdata.enumerated().forEach { args in
    let (idx, testData) = args
    print("Day2_1 Checksum Test \(idx): \(getChecksum(input: testData.values) == testData.res)")
}

//: Testing Day Function

let dayTestdata = (values:"abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab\n", res: 12)

print("Day2_1 Test : \(day2_1(with: dayTestdata.values) == dayTestdata.res)")


//: Getting the result of our problemset

let inputData = Helper.getInput(name: "Input", fileType: "txt")!
print("Day1_2 Result: \(day2_1(with: inputData))")

/*:
 My result of Day 1 Part 2 is: `6723`

 [Day 2 Part 2](Day2_2)
 */
