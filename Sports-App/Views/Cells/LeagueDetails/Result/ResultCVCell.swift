//
//  ResultCVCell.swift
//  Sports-App
//
//  Created by Adham Samer on 06/02/2023.
//

import UIKit

class ResultCVCell: UICollectionViewCell {

    @IBOutlet weak var homeResult: UILabel!
    
    @IBOutlet weak var homeImage: UIImageView!
    
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var awayResult: UILabel!
    
    @IBOutlet weak var awayLabel: UILabel!
    
    @IBOutlet weak var awayImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        // Initialization code
    }

}
