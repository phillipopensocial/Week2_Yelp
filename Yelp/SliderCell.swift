//
//  SliderCell.swift
//  Yelp
//
//  Created by Phillip Pang on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit


@objc protocol SliderCellDelegate{
    @objc optional func SliderCell( sliderCell: SliderCell, didChangeValue: Int)
}


class SliderCell: UITableViewCell {

    
    @IBOutlet weak var gSlider: UISegmentedControl!
    
    weak var delegate: SliderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gSlider.addTarget(self, action: #selector(SliderCell.sliderValueChanged), for: UIControlEvents.valueChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func sliderValueChanged(){
        print("\nSlider Changed")
        if delegate != nil {
            delegate?.SliderCell!(sliderCell: self, didChangeValue: gSlider.selectedSegmentIndex)
        }
    }
    
    
    
}
