//
//  SwipingCollectionViewModel.swift
//  AutoLayoutProgrammatically
//
//  Created by Matheus Oliveira Costa on 01/07/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit

final class SwipingCollectionViewModel: NSObject {
    
    private(set) var pages: [Page]
    
    override init() {
        self.pages = [
            Page(imageName: "bear_first", headline: "Join us today", text: "You need this"),
            Page(imageName: "bear_first", headline: "Let's play!", text: "Are you ready?")
        ]
    }
    
}
