//
//  ViewController.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/21/21.
//
import SDWebImage
import UIKit

class MovieListViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel = MovieViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        viewModel.fetchMovieData(completion: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
            
    }


}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCount()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell
        
        cell?.layer.cornerRadius = 6
        
        cell?.movieObject = viewModel.getMovieForCell(at: indexPath.item)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
        
        guard let movie = viewModel.getMovieForCell(at: indexPath.item) else { return }
        vc?.setMovie(movie: movie)
        navigationController?.present(vc!, animated: true, completion: nil)
    }
}

