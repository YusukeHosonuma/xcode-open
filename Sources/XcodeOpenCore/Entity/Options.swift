//
//  Options.swift
//  XcodeOpenCore
//
//  Created by Yusuke on 2018/01/20.
//

import Foundation

public struct Options {
    
    public let version: String?
    public let save: Bool
    
    public init(version: String?, save: Bool) {
        self.version = version
        self.save = save
    }
}

