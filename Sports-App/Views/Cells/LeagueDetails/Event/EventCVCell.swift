//
//  EventCVCell.swift
//  Sports-App
//
//  Created by Adham Samer on 06/02/2023.
//

import UIKit

class EventCVCell: UICollectionViewCell {

    @IBOutlet weak var awayImageE: UIImageView!
    @IBOutlet weak var homeImageE: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        // Initialization code
    }

}
