//
//  CustomTableViewCell.swift
//  SqlDemo
//
//  Created by Mac on 09/10/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
