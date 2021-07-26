//
//  MovieDetailsViewController.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/22/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var homePageLabel: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
   
    var vm: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setMovie(movie: Movie){
        vm = DetailViewModel()
        vm?.delegate = self
        vm?.setMovieObject(movie: movie)
        
    }
    
}
extension MovieDetailsViewController: DetailViewModelProtocol{
    func didReceiveMovie(movie: Movie) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title ?? ""
            self.releaseLabel.text = "Release date: \(movie.release_date ?? "")"
            self.runtimeLabel.text = "Runtime: \(movie.runtime?.description ?? "")"
            self.scoreLabel.text = "Score: \(movie.popularity?.description ?? "")"
            self.homePageLabel.text = "Homepage: \(movie.homepage ?? "")"
            self.movieDescription.text = movie.overview ?? ""
            
            self.imgView.sd_setImage(with: URL(string: Constants.imageUrlBase.rawValue + (self.vm?.movieObject?.poster_path ?? "")), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: nil)

        }
    }
    
    
}
