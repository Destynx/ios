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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
    }

    func load() {
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.summary
        self.fetchImage()
        self.loadLikeButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func likeOrDislike(_ sender: UIButton) {
        if(_webservice.isLoggedIn()) {
            _webservice.likeArticle(Id: article.id, like: !article.isliked)
            article.isliked = !article.isliked
            self.loadLikeButton()
        } else {
            let alert = UIAlertController(title: "Login", message: "Login is required to use this function", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func loadLikeButton() {
        if(article.isliked) {
            likeButton.setTitle("Dislike", for: .normal)
        } else {
            likeButton.setTitle("Like", for: .normal)
        }
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

