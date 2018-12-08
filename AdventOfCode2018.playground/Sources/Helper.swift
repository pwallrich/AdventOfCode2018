import Foundation

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
}
