//
//  ViewController.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import UIKit
import Kingfisher
import SVProgressHUD

class MoviesViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var movieTblView: UITableView!
    private var movieViewModel = MovieViewModel()
    private var movies: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMoviesList()
    }
}

//MARK: - API call
extension MoviesViewController {
    func getMoviesList(){
        SVProgressHUD.show()
        movieViewModel.getMovies { success, moviesResponse in
            if success {
                self.movies = moviesResponse ?? []
                DispatchQueue.main.async {
                    self.movieTblView.reloadData()
                }
                SVProgressHUD.dismiss()
            }else{
                SVProgressHUD.dismiss()
            }
        }
    }
    
}

//MARK: - TableView Datasource + Delegates Methods
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTblView.dequeueReusableCell(withIdentifier: "cell") as! MoviesTableViewCell
        
        let movie = movies[indexPath.row]
        let posterImage = "\(IMAGE_BASE_URL)\(movie.posterPath)"
        let url = URL(string: posterImage)
        cell.mPosterImgView.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetails.movieId = movies[indexPath.row].id
        navigationController?.pushViewController(movieDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

//MARK: - TableView Cell
class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var mPosterImgView: UIImageView!
}

