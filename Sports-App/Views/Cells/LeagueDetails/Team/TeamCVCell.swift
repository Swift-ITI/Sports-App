//
//  TeamCVCell.swift
//  Sports-App
//
//  Created by Adham Samer on 07/02/2023.
//

import UIKit
import SwiftUI

class TeamCVCell: UICollectionViewCell {

    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        teamLogo.layer.cornerRadius = teamLogo.frame.height/2
        teamLogo.layer.borderColor = Color.accentColor.cgColor
        teamLogo.layer.borderWidth = 1.5
        // Initialization code
    }

}
