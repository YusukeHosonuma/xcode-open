import Foundation
import XcodeOpenCore
import Commander

let version = "1.1.0"

fileprivate func main(_ f: @escaping (XcodeOpenCore.Options) throws -> ()) -> CommandType {
    if CommandLine.arguments.count == 1 {
        return command {
            try f(Options(version: nil, save: false))
        }
    } else {
        return command(
                Argument<String>("version", description: "which version of Xcode to open"),
                Flag("save", description: "Remember version of Xcode (save to '.xcode_version')")
        ) { version, save in
            try f(Options(version: version, save: save))
        }
    }
}

main { (options: XcodeOpenCore.Options) in
    do {
        let tool = XcodeOpen(options: options)
        try tool.execute()
    } catch {
        fail("Error... \(error)")
    }
}.run(version)
