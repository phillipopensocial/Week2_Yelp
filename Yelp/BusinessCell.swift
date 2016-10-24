//
//  BusinessCell.swift
//  Yelp
//
//  Created by Phillip Pang on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var gThumbImageView: UIImageView!
    @IBOutlet weak var gNameLabel: UILabel!
    @IBOutlet weak var gDistanceLabel: UILabel!
    @IBOutlet weak var gRatingImageView: UIImageView!
    @IBOutlet weak var gReviewCountLabel: UILabel!
    @IBOutlet weak var gAddressLabel: UILabel!
    @IBOutlet weak var gCategoriesLabel: UILabel!

    var business:Business! {
        didSet{
            gNameLabel.text = business.name
            gAddressLabel.text = business.address
            gThumbImageView.setImageWith(business.imageURL!)
            gCategoriesLabel.text = business.categories
            gDistanceLabel.text = business.distance
            gReviewCountLabel.text = "\(business.reviewCount) reviews"
            gRatingImageView.setImageWith(business.ratingImageURL!)

        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Make Image round
        gThumbImageView.layer.cornerRadius = 3
        gThumbImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
