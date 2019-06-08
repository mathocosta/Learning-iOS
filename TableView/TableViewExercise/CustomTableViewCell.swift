//
//  CustomTableViewCell.swift
//  TableViewExercise
//
//  Created by Ada 2018 on 25/04/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
