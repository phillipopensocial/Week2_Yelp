//
//  SwitchCell.swift
//  Yelp
//
//  Created by Phillip Pang on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate{
    @objc optional func SwitchCell( switchCell: SwitchCell, didChangeValue: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var gSwitchLabel: UILabel!
    @IBOutlet weak var gOnSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gOnSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func switchValueChanged(){
        print("\nSwitchChanged")
        if delegate != nil {
            delegate?.SwitchCell!(switchCell: self, didChangeValue: gOnSwitch.isOn)
        }
    }
    
}
