//
//  TeamCVCell.swift
//  Sports-App
//
//  Created by Adham Samer on 07/02/2023.
//

import UIKit

class TeamCVCell: UICollectionViewCell {

    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        teamLogo.layer.cornerRadius = teamLogo.frame.height/2
        // Initialization code
    }

}
