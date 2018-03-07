//
//  XcodeApplicationDetector.swift
//  XcodeOpenCore
//
//  Created by Yusuke Hosonuma on 2018/03/08.
//

import Foundation

public class XcodeApplicationDetector {
    public static func detect(version: String, paths: [String]) -> String? {
        return paths
            .filter { $0.contains("Xcode") && $0.contains(version) }
            .first
    }
}
