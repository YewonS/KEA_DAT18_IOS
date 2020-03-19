//
//  Story.swift
//  customCellDemo
//
//  Created by Yewon Seo on 2020/03/13.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import Foundation
class Story {
    
    var text:String = ""
    var image:String = ""
    
    init(txt:String, img:String) {
        text = txt
        image = img
    }
    
    func hasImage() -> Bool {
        return image.count > 0  // returns true when there is image
    }
    
}
