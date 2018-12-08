//: [Home](Main)
/*:
 ## Day 1 Part 1
 ### Task:
 After feeling like you've been falling for a few minutes, you look at the device's tiny screen. "Error: Device must be calibrated before first use. Frequency drift detected. Cannot maintain destination lock." Below the message, the device shows a sequence of changes in frequency (your puzzle input).

 A value like +6 means the current frequency increases by 6; a value like -3 means the current frequency decreases by 3.

 For example, if the device displays frequency changes of `+1, -2, +3, +1`, then starting from a frequency of zero, the following changes would occur:
```
 Current frequency  0, change of +1; resulting frequency  1.
 Current frequency  1, change of -2; resulting frequency -1.
 Current frequency -1, change of +3; resulting frequency  2.
 Current frequency  2, change of +1; resulting frequency  3.
```
 In this example, the resulting frequency is 3.

 Here are other example situations:
```
 +1, +1, +1 results in  3
 +1, +1, -2 results in  0
 -1, -2, -3 results in -6
```
 Starting with a frequency of zero, what is the resulting frequency after all of the changes in frequency have been applied?
*/

import Foundation

func day1_1(with input: String) -> Int {
    return input
        .split(separator: "\n")
        .reduce(0, { return $0 + (Int($1) ?? 0) })
}

//: Testing our function with te test Data given in the problem description

let testdata = [
     (values: "+1\n-2\n+3\n+1", res: 3),
     (values: "+1\n+1\n+1", res: 3),
     (values: "+1\n+1\n-2", res: 0),
     (values: "-1\n-2\n-3", res: -6)
]

testdata.enumerated().forEach { args in
    let (idx, testData) = args
    print("Day1_1 Test \(idx): \(day1_1(with: testData.values) == testData.res)")
}

//: Getting the result of our problemset

let inputData = Helper.getInput(name: "1-Input", fileType: "txt")!
print("Day1_1 Result: \(day1_1(with: inputData))")

/*:
 My result of Day 1 Part 1 is: `416`

 [Day 1 Part 2](Day1_2)
*/
