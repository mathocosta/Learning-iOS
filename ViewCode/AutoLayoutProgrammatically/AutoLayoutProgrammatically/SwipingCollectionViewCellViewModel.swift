//
//  SwipingCollectionViewCellViewModel.swift
//  AutoLayoutProgrammatically
//
//  Created by Matheus Oliveira Costa on 01/07/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit

final class SwipingCollectionViewCellViewModel: NSObject {
    
    private let page: Page
    
    var headline: String {
        return self.page.headline
    }
    
    var text: String {
        return self.page.text
    }
    
    var image: UIImage {
        let image = UIImage(named: self.page.imageName)!
        return image
    }
    
    init(page: Page) {
        self.page = page
    }
    
}
