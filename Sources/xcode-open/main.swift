import Foundation
import Files
import SwiftShell

let applications = try Folder(path: "/Applications").subfolders
let subfolders   = try Folder(path: ".").subfolders

var args = CommandLine.arguments
args.removeFirst()

let argsVersion = args.first

// save .xcode_version
if let version = argsVersion, args.contains("--save") {
    do {
        try Folder(path: ".").createFile(named: ".xcode_version")
        try File(path: ".xcode_version").write(string: version)
    } catch {
        print("Faild to save .xcode_version.")
        exit(-1)
    }
}

var specifyVersion: String? = nil
do {
    let content = try File(path: ".xcode_version").readAsString()
    specifyVersion = content.split(separator: "\n").first.map(String.init)
} catch {
    // do nothing
}

var xcodePath: String? = nil

// use default if nil
let version: String? = argsVersion ?? specifyVersion

// detecte xcode
if let version = version {
    
    let xcode = applications
        .filter { $0.name.contains("Xcode") && $0.name.contains(version) }
        .first
    
    guard let path = xcode?.path else {
        print("Xcode \(version) is not found.")
        exit(-1)
    }
    
    xcodePath = path
}


// detecte workspace or project
let projects = [
        subfolders.filter { $0.name.hasSuffix(".xcworkspace") }.map { $0.name }.first,
        subfolders.filter { $0.name.hasSuffix(".xcodeproj")   }.map { $0.name }.first
    ].flatMap { $0 }

guard let project = projects.first else {
    print("Xcode Project(.xcworkspace or .xcodeproj is not found.")
    exit(-1)
}

// open Xcode
let result: RunOutput

if let path = xcodePath, let version = version {
    print("Open Xcode \(version) ...")
    result = run("open", "-a", path, project)
} else {
    print("Open Xcode...")
    result = run("open", project)
}

if result.exitcode != 0 {
    print("Failed to open Xcode.")
}
