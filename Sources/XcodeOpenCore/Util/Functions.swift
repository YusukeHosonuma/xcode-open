//
//  Functions.swift
//  XcodeOpenCore
//
//  Created by Yusuke on 2018/01/20.
//

import Foundation

public func fail(_ message: String) -> Never {
    print(message)
    exit(-1)
}
