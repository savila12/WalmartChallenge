//
//  CustomCollectionViewController.swift
//  WalmartChallenge
//
//  Created by Matthew Hernandez on 7/21/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell{
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    var movieObject: Movie? {
        willSet(value){
            guard let value = value else {return}
            self.titleLabel.text = "Title: \(value.title ?? "-")"
            self.scoreLabel.text = "Score: \(value.popularity?.description ?? "-")"
            self.releaseLabel.text = "Release Year: \(value.release_date ?? "-")"
            self.genreLabel.text = "Genre: \(value.genre?.name ?? "-")"

            imgView.sd_setImage(with: URL(string: Constants.imageUrlBase.rawValue + (value.poster_path ?? "")), completed: nil)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
