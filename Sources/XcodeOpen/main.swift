import Foundation
import XcodeOpenCore

do {
    let args = CommandLine.arguments.dropFirst()
    
    let version = args.first
    
    if version == "--save" {
        print("Please launch with specify version of Xcode when used `--save`")
        print("Usage: XcodeOpen <version> --save")
        exit(-1)
    }

    let save = args.contains("--save")
    let options = Options(version: version, save: save)
    let tool = XcodeOpen(options: options)
    try tool.execute()
} catch {
    fail("Error... \(error)")
}
