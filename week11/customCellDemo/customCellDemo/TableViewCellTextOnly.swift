//
//  TableViewCellTextOnly.swift
//  customCellDemo
//
//  Created by Yewon Seo on 2020/03/13.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit

class TableViewCellTextOnly: UITableViewCell {

    @IBOutlet weak var mylabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
