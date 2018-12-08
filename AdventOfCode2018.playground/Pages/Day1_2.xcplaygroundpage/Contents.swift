//: [Home](Main)
/*:
 You notice that the device repeats the same frequency change list over and over. To calibrate the device, you need to find the first frequency it reaches twice.

 For example, using the same list of changes above, the device would loop as follows:
 ```
 Current frequency  0, change of +1; resulting frequency  1.
 Current frequency  1, change of -2; resulting frequency -1.
 Current frequency -1, change of +3; resulting frequency  2.
 Current frequency  2, change of +1; resulting frequency  3.
 (At this point, the device continues from the start of the list.)
 Current frequency  3, change of +1; resulting frequency  4.
 Current frequency  4, change of -2; resulting frequency  2, which has already been seen.
```
 In this example, the first frequency reached twice is 2. Note that your device might need to repeat its list of frequency changes many times before a duplicate frequency is found, and that duplicates might be found while in the middle of processing the list.

 Here are other examples:
```
 +1, -1 first reaches 0 twice.
 +3, +3, +4, -2, -4 first reaches 10 twice.
 -6, +3, +8, +5, -6 first reaches 5 twice.
 +7, +7, -2, -7, -4 first reaches 14 twice.
```
 What is the first frequency your device reaches twice?
*/
import Foundation

/// A class iterating over an array, repeating the contents of the array over and over again
/// i.e. Array(1,2,3) -> 1, 2, 3, 1, 2, 3, 1, 2, 3,..
class RepeatingArray<T> {
    private let array: [T]

    init(array: [T]) {
        self.array = array
    }

    func createRepeating() -> AnySequence<T> {
        return AnySequence { () -> AnyIterator<T> in
            var idx = 0

            return AnyIterator {
                let res = self.array[idx]
                idx = (idx + 1) % self.array.count
                return res
            }
        }
    }
}

func day1_2(with input: String) -> Int {
    let sequence = input.split(separator: "\n").map { Int($0) ?? 0}
    var seen = Set<Int>()
    seen.insert(0)
    var last = 0
    for e in RepeatingArray(array: sequence).createRepeating() {
        last = last + e
        if seen.contains(last) {
            return last
        }
        seen.insert(last)
    }
    return 0
}

//: Testing our function with te test Data given in the problem description

let testdata = [
    (values: "+3\n+3\n+4\n-2\n-4", res: 10),
    (values: "+1\n-1", res: 0),
    (values: "+7\n+7\n-2\n-7\n-4", res: 14),
    (values: "-1\n-2\n-3", res: -6)
]

testdata.enumerated().forEach { args in
    let (idx, testData) = args
    print("Day1_2 Test \(idx): \(day1_2(with: testData.values) == testData.res)")
}

//: Getting the result of our problemset

let inputData = Helper.getInput(name: "1-Input", fileType: "txt")!
print("Day1_2 Result: \(day1_2(with: inputData))")

/*:
 My result of Day 1 Part 2 is: `56752`

 [Day 2 Part 1](Day2_1)
 */
