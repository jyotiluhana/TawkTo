//
//  Encodable+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 11/10/21.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        if self.count > 0 {
            output.removeLast()
        }
        return output
    }
}
