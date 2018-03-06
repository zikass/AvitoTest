//
//  ListViewCell.swift
//  AvitoProjectTest
//
//  Created by Zakaria elmouatassim on 05/03/2018.
//  Copyright © 2018 Zakaria elmouatassim. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var imageAds: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var nameUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
