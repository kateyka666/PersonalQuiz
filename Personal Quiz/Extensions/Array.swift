//
//  Array.swift
//  Personal Quiz
//
//  Created by Екатерина Боровкова on 02.06.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import Foundation
extension Array where Element: Hashable {
    var counting: [Element: Int] {
        return self.reduce(into: [:]) { type, counts in type[counts, default: 0] += 1 }
    }
}
