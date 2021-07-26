//
//  MoviesView.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/21/21.
//

import Foundation

class MovieViewModel {
    
   
    var dataFromMovie: [Movie]?
    var genres: [Genre]?
    var currentPage = 1
    let apiHandler = APIHandler.shared
    
    /// Function to update list of genres
    /// - Parameter 
    ///     - completion: called after genres are updated
    func getGenres(completion: @escaping ()->()){
        apiHandler.getData(endpoint: .genres){
            [weak self] resp in
            guard let genres = (resp as? Genres)?.genres, let self = self else {return}
            self.genres = genres
            completion()
        }
    }
   
    
    /// Function to get the movies form the popular url
    /// - Parameter 
    ///     - page: page number
    ///     - completion: called after getting movies is done
    func fetchMovies(page: Int? = 1, completion: @escaping ()->()) {
        apiHandler.getData(endpoint: .popularMovies, page: page) {
            [weak self] resp in
            guard let movies = (resp as? Movies)?.results, let self = self else {return}
            self.dataFromMovie == nil ? self.dataFromMovie = movies : self.dataFromMovie?.append(contentsOf: movies)
            completion()
        }
    }
    
    
    /// Function using DispatchGroup and gets genres and movies 1 at a time
    /// - Parameter
    ///     - completion: called after getting each genre and movie
    func fetchMovieData(completion:@escaping () -> ()) {
        /// Create a dispatch group to attach multiple work items to a group and schedule them asynchronously
        let dispatchGroup = DispatchGroup()
        if genres == nil {
            dispatchGroup.enter()
            getGenres {
                dispatchGroup.leave()
            }
        }
        dispatchGroup.enter()
        fetchMovies(page: self.currentPage) {
            self.currentPage += 1
           dispatchGroup.leave()
       }

        dispatchGroup.notify(queue: .global(), work: DispatchWorkItem(block: {
            completion()
        }))
    }
    
    /// Functions to get access to a specific movie in cell
    /// - Parameter
    ///     - item: number for item in cell view
    ///     - return: Movie object
    func getMovieForCell(at item: Int) -> Movie? {
        guard let movie = dataFromMovie?[item],
              let genreID = movie.genre_ids?.first else {return nil}
        
        let genre = genres?.filter{$0.id == genreID}
        
        return Movie(genre_ids: movie.genre_ids, id: movie.id, poster_path: movie.poster_path, release_date: movie.release_date, title: movie.title, popularity: movie.popularity, runtime: movie.runtime, homepage: movie.homepage, overview: movie.overview, movieLink: movie.movieLink, genre: genre?.first)
    }
    
    /// Function to get number of movies in array
    /// Return: the number of items for collection view corresponding to the number of movie object
    func getMoviesCount() -> Int {
        return dataFromMovie?.count ?? 0
    }
}
