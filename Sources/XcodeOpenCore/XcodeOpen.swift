import Foundation
import Files
import SwiftShell

public final class XcodeOpen {

    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func execute() throws {

        var args = arguments
        args.removeFirst()

        let argsVersion = args.first

        if let version = argsVersion, args.contains("--save") {
            saveXcodeVersion(version)
        }

        let version: String? = argsVersion ?? loadXcodeVersion()

        var xcodePath: String? = nil
        if let version = version {
            xcodePath = try detectXcode(version: version)
        }

        let project = try detectProjectFile()

        if !launchXcode(project, xcodePath: xcodePath, version: version) {
            print("Failed to open Xcode.")
        }
    }
    
    private func launchXcode(_ project: String, xcodePath: String?, version: String?) -> Bool {
        
        let result: RunOutput
        
        if let path = xcodePath, let version = version {
            print("Open Xcode \(version) ...")
            result = run("open", "-a", path, project)
        } else {
            print("Open Xcode...")
            result = run("open", project)
        }
        
        return result.exitcode == 0
    }
    
    private func loadXcodeVersion() -> String? {
        do {
            let content = try File(path: ".xcode_version").readAsString()
            let version = content.split(separator: "\n").first.map(String.init)
            return version
        } catch {
            // do nothing
        }
        return nil
    }
    
    private func saveXcodeVersion(_ version: String) {
        do {
            try Folder(path: ".").createFile(named: ".xcode_version")
            try File(path: ".xcode_version").write(string: version)
        } catch {
            fatalError("Faild to save .xcode_version.")
        }
    }
    
    private func detectXcode(version: String) throws -> String {
        
        let xcode = try Folder(path: "/Applications")
            .subfolders
            .filter { $0.name.contains("Xcode") && $0.name.contains(version) }
            .first
        
        guard let path = xcode?.path else {
            fatalError("Xcode \(version) is not found.")
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
            fatalError("Xcode Project (.xcworkspace or .xcodeproj is not found.")
        }

        return project
    }
}
