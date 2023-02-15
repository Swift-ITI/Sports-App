//
//  CustomCollectionViewCell.swift
//  Sports-App
//
//  Created by MESHO on 02/02/2023.
//

import UIKit
import SwiftUI

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportsImageView: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 20
        //sportsImageView.layer.cornerRadius = sportsImageView.frame.height/2
        
        self.layer.borderColor = Color.accentColor.cgColor
        self.layer.borderWidth = 2
    }

}
