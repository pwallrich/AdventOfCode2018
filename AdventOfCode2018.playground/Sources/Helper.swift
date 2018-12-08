import Foundation
import UIKit

public class Helper {
    /// loads the input from the file
    /// - Parameters:
    ///     - name: The name of the file
    ///     - fileType: The filetype of the file
    /// - Returns: The content of the file as String or nil if the content couldn't be parsed to a string
    public static func getInput(name: String, fileType: String) -> String? {
        if let url = Bundle.main.url(forResource: name, withExtension: fileType),
            let content = try? String(contentsOf: url, encoding: String.Encoding.utf8) {
            return content
        }
        return nil
    }

    public static func saveImageFromPaths(_ rects:[CGRect]) {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1000, height: 1000), false, 0)
        rects.enumerated().forEach { idx, rect in
            var rectCol = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 0.1)
            if idx == 680 {
                rectCol = UIColor(red: 1.0, green: 0, blue: 1.0, alpha: 1)
            }
            rectCol.setStroke()
            rectCol.setFill()

            let rectPath = UIBezierPath(rect: rect)
            rectPath.stroke()
            rectPath.fill()
            let textFontAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 5),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                ]
            ("\(idx)" as NSString).draw(at: rect.origin, withAttributes: textFontAttributes)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let dir = try! FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        let filePath = dir.appendingPathComponent("bezier.jpg")
        print(filePath)
        try! image!.jpegData(compressionQuality: 1)?.write(to: filePath)
    }

}
