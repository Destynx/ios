//
//  ViewController.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton : UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var article : Article!
    let webservice = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
    }

    func load() {
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.summary
        self.fetchImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func likeOrDislike(_ sender: UIButton) {
        if(article.isliked){webservice.unLikeArticle(Id: article.id)} else{webservice.likeArticle(Id: article.id)}
        
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
                        self.imageView.image = image
                    } else {
                        image = nil
                    }
                }
            }
        }
    }

}

