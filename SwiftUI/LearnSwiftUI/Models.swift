//
//  Models.swift
//  LearnSwiftUI
//
//  Created by Matheus Costa on 08/06/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import Foundation

// MARK: - Post
struct Post {
    let id: Int
    let username, text, imageName: String
}

// MARK: - Group
struct Group {
    let id: Int
    let text, imageName: String
}
