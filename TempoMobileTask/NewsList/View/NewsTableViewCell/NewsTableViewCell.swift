//
//  NewsTableViewCell.swift
//  TempoMobileTask
//
//  Created by mina wefky on 18/06/2021.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var articaleImage: UIImageView!
    @IBOutlet weak var articaleDescription: UILabel!
    @IBOutlet weak var articaleSource: UILabel!
    
    var article: Article? {
        didSet {
            articaleImage.sd_setImage(with: URL(string: article?.urlToImage ?? ""), completed: nil)
            articaleDescription.text = article?.articleDescription
            articaleSource.text = article?.source.name 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
