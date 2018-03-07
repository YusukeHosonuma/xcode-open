//
//  XcodeProjectDetector.swift
//  XcodeOpenCore
//
//  Created by Yusuke Hosonuma on 2018/03/08.
//

import Foundation

public class XcodeProjectDetector {
    public static func detect(folders: [String]) -> String? {
        let projects = [
            folders.first { $0.hasSuffix(".xcworkspace") },
            folders.first { $0.hasSuffix(".xcodeproj") },
            ].flatMap { $0 }
        return projects.first
    }
}
