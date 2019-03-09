//
//  PupilsTableViewCell.swift
//  htc
//
//  Created by Princess Max on 07.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import UIKit
class PupilsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var lastNameLable: UILabel!
    @IBOutlet weak var gradePointAverageLable: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.addShadowAndRounderCorners()
    }
    func setup(pupilModel:PupilModel){
        self.nameLable.text = pupilModel.name
        self.lastNameLable.text = pupilModel.lastName
        self.gradePointAverageLable.text = "\(pupilModel.gradePointAverage)"
    }
}
