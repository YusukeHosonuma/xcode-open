//
//  XcodeVersionFile.swift
//  XcodeOpenCore
//
//  Created by Yusuke on 2018/01/20.
//

import Foundation
import Files

public class XcodeVersionFile {
    
    let filename: String
    
    public init(filename: String) {
        self.filename = filename
    }
    
    public func read() -> String? {
        do {
            let content = try File(path: filename).readAsString()
            let version = content.split(separator: "\n").first.map(String.init)
            return version
        } catch {
            // do nothing
        }
        return nil
    }
    
    public func write(_ version: String) {
        do {
            try Folder(path: ".").createFile(named: filename)
            try File(path: filename).write(string: version)
        } catch {
            fail("Faild to save .xcode_version.")
        }
    }
}
