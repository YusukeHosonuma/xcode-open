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
            folders.filter { $0.hasSuffix(".xcworkspace") }.first,
            folders.filter { $0.hasSuffix(".xcodeproj")   }.first
            ].flatMap { $0 }
        return projects.first
    }
}
