//: [Home](Main)

/*:
 ## Day 3 Part 2
 Amidst the chaos, you notice that exactly one claim doesn't overlap by even a single square inch of fabric with any other claim. If you can somehow draw attention to it, maybe the Elves will be able to make Santa's suit after all!

 For example, in the claims above, only claim 3 is intact after all claims are made.

 What is the ID of the only claim that doesn't overlap?

 The current solution isn't really quick yet, so smth else should be used. Maybe creating a Matrix upfront and checking with the matrix if the regions overlap
 */
import Foundation
import UIKit
import PlaygroundSupport

extension Int {
    init?(withRegex regex:String, from: String) {
        guard let range = from.range(of: regex, options: .regularExpression) else {
            return nil
        }
        self.init(String(from[range]))
    }
}

struct Rect: Equatable {
    let id: Int
    let width: Int
    let height: Int
    let x: Int
    let y: Int

    init?(from string: String) {
        let xRegEx = "(?<=\\@.)[0-9]+(?=,)"
        let yRegEx = "(?<=,)[0-9]+(?=:)"
        let widthRegEx = "(?<=: )[0-9]+(?=x)"
        let heightRegEx = "(?<=x)[0-9]+"
        let idRegEx = "(?<=^#)[0-9.]+(?= )"
        if let x = Int(withRegex: xRegEx, from: string),
            let y = Int(withRegex: yRegEx, from: string),
            let width = Int(withRegex: widthRegEx, from: string),
            let height = Int(withRegex: heightRegEx, from: string),
            let id = Int(withRegex: idRegEx, from: string) {
            self.init(width: width, height: height, x: x, y: y, id: id)
        } else {
            return nil
        }
    }

    var xRange: Range<Int> {
        return x..<(x + width)
    }

    var yRange: Range<Int> {
        return y..<(y + height)
    }

    var cgRect: CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }

    init(width: Int, height: Int, x: Int, y: Int, id: Int) {
        self.width = width
        self.height = height
        self.x = x
        self.y = y
        self.id = id
    }

    func overlaps(with rect: Rect) -> Bool {
        return rect.xRange.overlaps(xRange) &&
               rect.yRange.overlaps(yRange)
    }
}

func getRects(from data: String) -> [Rect] {
    return data
        .split(separator: "\n")
        .map { Rect(from: String($0))! }
}

func day3_1(with data: String) -> Int? {
    let values = getRects(from: data)
    for (idx, rect) in values.enumerated() {
        var overlaps = false
        for i in 0..<values.count {
            if i == idx {
                continue
            }
            if rect.overlaps(with: values[i]) {
                overlaps = true
                break
            }
        }
        if !overlaps {
            return rect.id
        }
    }
    return nil
}

//: Testing Rect initialiser
let rectTest = (value: "#1 @ 1,3: 4x4", res: Rect(width: 4, height: 4, x: 1, y: 3, id: 1))
let rectRes = Rect(from: rectTest.value) == rectTest.res

//: Testing our function with the test Data given in the problem description
let testStrings = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

let testData = (values: testStrings.joined(separator: "\n"), res: 3)
let testRes = day3_1(with: testData.values) == testData.res
print("Day3_1 Test: \(testRes)")

let inputData = Helper.getInput(name: "Input", fileType: "txt")!

//: Dumping Bezier Paths to image
//Helper.saveImageFromPaths(getRects(from: inputData).map { $0.cgRect })

//: #### The Paths plotted to an image
//: ![Elf Graph](bezier.jpg)
//: In the Graph the number is the array index, so the result index is 681
//: #### Getting the result if the tests are working

if testRes && rectRes {
    print("Day3_1 Result: \(day3_1(with: inputData))")
} else {
    print("Tests didn't pass")
}

/*:
 My result of Day 3 Part 2 is: `681`

 [Day 4 Part 1](Day4_1)
 */
