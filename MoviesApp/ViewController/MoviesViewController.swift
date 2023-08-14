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
    private var movies: [MovieModel] = []
    var viewModel: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieViewModel()
        viewModel.onError = { error in
            print("Error fetching movie list: \(error)")
        }
        
        SVProgressHUD.show()
        viewModel.getMovies { success, movieResultResp in
            DispatchQueue.main.async {
                self.movieTblView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
}

//MARK: - TableView Datasource + Delegates Methods
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTblView.dequeueReusableCell(withIdentifier: "cell") as! MoviesTableViewCell
        let movie = viewModel.movieList[indexPath.row]
        let posterImage = "\(IMAGE_BASE_URL)\(movie.posterPath)"
        let url = URL(string: posterImage)
        cell.mPosterImgView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetails.movieId = viewModel.movieList[indexPath.row].id
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

