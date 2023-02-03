//
//  CustomTableViewCell.swift
//  Sports-App
//
//  Created by MESHO on 03/02/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var btn_youTube: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        favImageView.layer.cornerRadius = favImageView.frame.height / 2

    }
    
}
