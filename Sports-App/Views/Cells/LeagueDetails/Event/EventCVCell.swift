//
//  EventCVCell.swift
//  Sports-App
//
//  Created by Adham Samer on 06/02/2023.
//

import UIKit
import SwiftUI

class EventCVCell: UICollectionViewCell {

    @IBOutlet weak var awayImageE: UIImageView!
    @IBOutlet weak var homeImageE: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        awayImageE.layer.cornerRadius = awayImageE.frame.height/2
        homeImageE.layer.cornerRadius = homeImageE.frame.height/2
        homeImageE.layer.borderColor = Color.accentColor.cgColor
        awayImageE.layer.borderColor = Color.accentColor.cgColor
        homeImageE.layer.borderWidth = 1.5
        awayImageE.layer.borderWidth = 1.5
        // Initialization code
    }

}
