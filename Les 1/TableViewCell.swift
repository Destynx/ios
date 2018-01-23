//
//  TableViewCell.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var lableTitle: UILabel!
    @IBOutlet weak var lableDescription: UILabel!
    
    public var article : Article!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    public func runImageFetch(){
        fetchImage()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setData(){
        lableTitle.text = article?.title
        lableDescription.text = article?.summary;
    }
    private func fetchImage() {
        let imageURL = URL(string: (article.image))
        var image: UIImage?
        
        if let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)
                        self.imageView?.image = image
                    } else {
                        image = nil
                    }
                }
            }
        }
    }
}