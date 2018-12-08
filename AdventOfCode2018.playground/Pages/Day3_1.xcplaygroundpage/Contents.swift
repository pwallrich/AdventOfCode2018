//: [Home](Main)

/*:
 The whole piece of fabric they're working on is a very large square - at least `1000` inches on each side.

 Each Elf has made a claim about which area of fabric would be ideal for Santa's suit. All claims have an ID and consist of a single rectangle with edges parallel to the edges of the fabric. Each claim's rectangle is defined as follows:

 The number of inches between the left edge of the fabric and the left edge of the rectangle.
 The number of inches between the top edge of the fabric and the top edge of the rectangle.
 The width of the rectangle in inches.
 The height of the rectangle in inches.

 A claim like `#123 @ 3,2: 5x4` means that claim ID `123` specifies a rectangle `3` inches from the left edge, `2` inches from the top edge, `5` inches wide, and `4` inches tall. Visually, it claims the square inches of fabric represented by `#` (and ignores the square inches of fabric represented by `.`) in the diagram below:
```
 ...........
 ...........
 ...#####...
 ...#####...
 ...#####...
 ...#####...
 ...........
 ...........
 ...........
```
 The problem is that many of the claims overlap, causing two or more claims to cover part of the same areas. For example, consider the following claims:
```
 #1 @ 1,3: 4x4
 #2 @ 3,1: 4x4
 #3 @ 5,5: 2x2
```
 Visually, these claim the following areas:
```
 ........
 ...2222.
 ...2222.
 .11XX22.
 .11XX22.
 .111133.
 .111133.
 ........
```
 The four square inches marked with X are claimed by both `1` and `2`. (Claim `3`, while adjacent to the others, does not overlap either of them.)

 If the Elves all proceed with their own plans, none of them will have enough fabric. How many square inches of fabric are within two or more claims?
 */

import Foundation

struct Rect: Equatable {

    let width: Int
    let height: Int
    let x: Int
    let y: Int

    init?(from string: String) {
        let xRegEx = "(?<=\\@.)[0-9]+(?=,)"
        let yRegEx = "(?<=,)[0-9]+(?=:)"
        let widthRegEx = "(?<=: )[0-9]+(?=x)"
        let heightRegEx = "(?<=x)[0-9]+"
        if let xRange = string.range(of: xRegEx, options: .regularExpression),
            let x = Int(string[xRange]),
            let yRange = string.range(of: yRegEx, options: .regularExpression),
            let y = Int(string[yRange]),
            let widthRange = string.range(of: widthRegEx, options: .regularExpression),
            let width = Int(string[widthRange]),
            let heightRange = string.range(of: heightRegEx, options: .regularExpression),
            let height = Int(string[heightRange]) {
            self.init(width: width, height: height, x: x, y: y)
        } else {
            return nil
        }
    }

    init(width: Int, height: Int, x: Int, y: Int) {
        self.width = width
        self.height = height
        self.x = x
        self.y = y
    }
}

func day3_1(with data: String) -> Int {
    var matrix = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
    return data.split(separator: "\n")
        .reduce(0) { res, str in
            var newRes = res
            let rect = Rect(from: String(str))!
            for x in rect.x..<(rect.x + rect.width) {
                for y in rect.y..<(rect.y + rect.height) {
                    matrix[x][y] += 1
                    if matrix[x][y] == 2 {
                        // if the value is 2 after increasing
                        // there was allready 1 item at that slot before
                        // therfore increasing counter. 3rd, 4th.. occurences won't increment
                        newRes += 1
                    }
                }
            }
            return newRes
        }
}

//: Testing Rect initialiser
let rectTest = (value: "#1 @ 1,3: 4x4", res: Rect(width: 4, height: 4, x: 1, y: 3))
let rectRes = Rect(from: rectTest.value) == rectTest.res
//: Testing our function with the test Data given in the problem description

let testStrings = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

let testData = (values: testStrings.joined(separator: "\n"), res: 4)
let testRes = day3_1(with: testData.values) == testData.res
print("Day3_1 Test: \(testRes)")

//: Getting the result if the tests are working

if testRes && rectRes {
    let inputData = Helper.getInput(name: "Input", fileType: "txt")!
    print("Day3_1 Result: \(day3_1(with: inputData))")
} else {
    print("Tests didn't pass")
}

/*:
 My result of Day 3 Part ^ is: `108961`

 [Day 3 Part 1](Day3_1)
 */
