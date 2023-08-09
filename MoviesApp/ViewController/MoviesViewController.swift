//
//  ViewController.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import UIKit
import Kingfisher

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var movieTblView: UITableView!
    private var getMovies = MovieViewModel()
    private var movies: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getMoviesList()
        }
    }
}

//MARK:- API call
extension MoviesViewController {
    func getMoviesList(){
        getMovies.getMovies { success, moviesResponse in
            if success {
                self.movies = moviesResponse ?? []
                DispatchQueue.main.async {
                    self.movieTblView.reloadData()
                }
            }else{
                print("no response")
            }
        }
    }
    
}

//MARK:- TableView Datasource + Delegates Methods
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTblView.dequeueReusableCell(withIdentifier: "cell") as! MoviesTableViewCell
        
        let movie = movies[indexPath.row]
        let posterImage = "https://image.tmdb.org/t/p/w500\(movie.posterPath)"
        let url = URL(string: posterImage)
        cell.mPosterImgView.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

//MARK:- TableView Cell
class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var mPosterImgView: UIImageView!
}

