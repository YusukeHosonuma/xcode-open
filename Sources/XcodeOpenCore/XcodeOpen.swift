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
        
        return result.exitcode == 0
    }

    private func detectXcode(version: String) throws -> String {
        
        let xcode = try Folder(path: "/Applications")
            .subfolders
            .filter { $0.name.contains("Xcode") && $0.name.contains(version) }
            .first
        
        guard let path = xcode?.path else {
            fail("Xcode \(version) is not found.")
        }
        
        return path
    }
    
    private func detectProjectFile() throws -> String {
        
        let subfolders = try Folder(path: ".").subfolders

        let projects = [
            subfolders.filter { $0.name.hasSuffix(".xcworkspace") }.map { $0.name }.first,
            subfolders.filter { $0.name.hasSuffix(".xcodeproj")   }.map { $0.name }.first
            ].flatMap { $0 }
        
        guard let project = projects.first else {
            fail("Xcode Project (.xcworkspace or .xcodeproj is not found.")
        }

        return project
    }
}
