//: [Home](Main)

/*:
 ## Day 2 Part 2
 The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:
```
 abcde
 fghij
 klmno
 pqrst
 fguij
 axcye
 wvxyz
```
 The IDs `abcde` and `axcye` are close, but they differ by two characters (the second and fourth). However, the IDs `fghij` and `fguij` differ by exactly one character, the third (h and u). Those must be the correct boxes.

 What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing `fgij`.)
*/

import Foundation

extension String {
    func getEqualElements(with second: String) -> String {
        return zip(self, second).filter { $0 == $1 }.reduce("", { $0 + "\($1.0)" })
    }

    func getDiffChars(from second: String) -> [(Character, Character)] {
        return zip(self, second).filter { $0 != $1 }
    }

    func almostEqual(to second: String) -> Bool {
        let difference = getDiffChars(from: second)
        return difference.count == 1
    }
}

func getStringsDifferingByOneChar(with data: [String]) -> (String, String) {
    for idx in 0..<data.count {
        let first = data[idx]
        for idx2 in (idx + 1)..<data.count {
            let second = data[idx2]
            if first.almostEqual(to: second) {
                return (first, second)
            }
        }
    }
    return ("", "")
}

func day2_2(with data: String) -> String {
    let values = data.split(separator: "\n").map { String($0) }
    let almostEquals = getStringsDifferingByOneChar(with: values)
    return almostEquals.0.getEqualElements(with: almostEquals.1)
}

//: Testing almostEqual

let almostEqualTestData = [
    (values: ("abcde","abcde"), res: false),
    (values:("abcde", "abcdf"), res: true),
    (values:("abcde", "abcfg"), res: false)
]

let almostEqualRes = almostEqualTestData.enumerated().reduce(true, { res, val in
    let (idx, testData) = val
    let testRes = testData.values.0.almostEqual(to: testData.values.1) == testData.res
    print("Day2_2 AlmostEqual Tests \(idx): \(testRes)")
    return res && testRes
})

print("Day2_2 All AlmostEqualTests: \(almostEqualRes)")

//: Testing equalChars

let equalTestData = [
    (values: ("abcde","abcde"), res: "abcde"),
    (values:("abcde", "abcdf"), res: "abcd"),
    (values:("abcde", "abcfg"), res: "abc")
]

let equalCharRes = equalTestData.enumerated().reduce(true, { res, val in
    let (idx, testData) = val
    let testRes = testData.values.0.getEqualElements(with: testData.values.1) == testData.res
    print("Day2_2 Equal Tests \(idx): \(testRes)")
    return res && testRes
})

print("Day2_2 All Equal: \(equalCharRes)")


//: Testing StringsDifferingByOne

let testStrings = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]

let differingTestData = (values: testStrings, res: ("fghij", "fguij"))
let differingTestRes = getStringsDifferingByOneChar(with: differingTestData.values) == differingTestData.res
print("Day2_2 Differing Tests: \(differingTestRes)")

//: Testing our function with the test Data given in the problem description

let testData = (values: testStrings.joined(separator: "\n"), res: "fgij")
let testRes = day2_2(with: testData.values) == testData.res
print("Day2_2 Test: \(testRes)")

//: Getting the result if the tests are working

if testRes && differingTestRes && almostEqualRes && equalCharRes {
    let inputData = Helper.getInput(name: "Input", fileType: "txt")!
    print("Day2_2 Result: \(day2_2(with: inputData))")
} else {
    print("Tests didn't pass")
}

/*:
 My result of Day 2 Part 2 is: `prtkqyluiusocwvaezjmhmfgx`

 [Day 3 Part 1](Day3_1)
 */
