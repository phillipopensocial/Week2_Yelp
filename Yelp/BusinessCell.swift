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
            if business.imageURL != nil {
                gThumbImageView.setImageWith(business.imageURL!)
            }
            gCategoriesLabel.text = business.categories
            gDistanceLabel.text = business.distance
            gReviewCountLabel.text = "\(business.reviewCount) reviews"
            if business.ratingImageURL != nil {
                gRatingImageView.setImageWith(business.ratingImageURL!)
            }


        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Make Image round
        gThumbImageView.layer.cornerRadius = 3
        gThumbImageView.clipsToBounds = true
        
        //Wrap text
        self.gNameLabel.preferredMaxLayoutWidth = self.gNameLabel.frame.size.width
        self.gCategoriesLabel.preferredMaxLayoutWidth = self.gCategoriesLabel.frame.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Wrap text
        self.gNameLabel.preferredMaxLayoutWidth = self.gNameLabel.frame.size.width
        self.gCategoriesLabel.preferredMaxLayoutWidth = self.gCategoriesLabel.frame.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
