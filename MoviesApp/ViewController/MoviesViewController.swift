//
//  ViewController.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var movieTblView: UITableView!
    var getMovies = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesList()
    }


}

//MARK:- API call
extension MoviesViewController {
    func getMoviesList(){
        getMovies.getMovies { success, moviesResponse in
            if success {
                print("moviesResponse--->",moviesResponse ?? "")
            }else{
                print("no response")
            }
        }
    }
    
}

//MARK:- TableView Datasource + Delegates Methods
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTblView.dequeueReusableCell(withIdentifier: "cell") as! MoviesTableViewCell
        
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

