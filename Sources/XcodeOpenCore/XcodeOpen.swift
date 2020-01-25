import Foundation
import Files
import SwiftShell

public final class XcodeOpen {

    private let options: Options
    private let xcodeVersionFile = XcodeVersionFile(filename: Consts.xcodeVersionFilename)

    public init(options: Options) {
        self.options = options
    }

    public func execute() throws {

        if let version = options.version, options.save {
            xcodeVersionFile.write(version)
        }

        let version: String? = options.version ?? xcodeVersionFile.read()

        var xcodePath: String? = nil

        if let version = version {
            xcodePath = try detectXcode(version: version)
        }

        let project = try detectProjectFile()

        if !launchXcode(project, xcodePath: xcodePath, version: version) {
            fail("Failed to open Xcode.")
        }
    }
    
    private func launchXcode(_ project: String, xcodePath: String?, version: String?) -> Bool {
        
        let result: RunOutput
        
        if let path = xcodePath, let version = version {
            print("Open Xcode \(version) ...")
            result = run("open", "-a", path, project)
        } else {
            print("Open Xcode ...")
            result = run("open", project)
        }

        if let _ = result.error {
            print(result.stderror)
        }
        
        return result.exitcode == 0
    }

    private func detectXcode(version: String) throws -> String {
        
        let paths = try Folder(path: "/Applications").subfolders.map { $0.path }

        guard let path = XcodeApplicationDetector.detect(version: version, paths: paths) else {
            fail("Xcode \(version) is not found.")
        }
        
        return path
    }
    
    private func detectProjectFile() throws -> String {
        
        let subfolders = try Folder(path: ".").subfolders
        
        guard let project = XcodeProjectDetector.detect(folders: subfolders.names()) else {
            fail("Xcode Project (.xcworkspace or .xcodeproj is not found.")
        }
        
        return project
    }
}
