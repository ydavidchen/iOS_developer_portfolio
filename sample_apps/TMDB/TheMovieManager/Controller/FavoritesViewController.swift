//  FavoritesViewController.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import UIKit;

class FavoritesViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!;
    var selectedIndex = 0;
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Essentially the SAME as Watchlist, just different ID used
        _ = TMDBClient.getFavourites() {(movies,error) in
            MovieModel.favorites = movies;
            self.tableView.reloadData();
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        tableView.reloadData();
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController;
            detailVC.movie = MovieModel.favorites[selectedIndex];
        }
    }
}

/*
Extension: TableView methods implementations
*/
extension FavoritesViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView:UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return MovieModel.favorites.count;
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MovieTableViewCell")!;
        let movie = MovieModel.favorites[indexPath.row];
        cell.textLabel?.text = movie.title;
        
        if let posterPath = movie.posterPath {
            TMDBClient.downloadPosterImage(path:posterPath){(data,error) in
                guard let data = data else {
                    return;
                }
                let image = UIImage(data:data);
                cell.imageView?.image = image;
                cell.setNeedsLayout();
            }
        }
        
        return cell;
    }
    
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath) {
        selectedIndex = indexPath.row;
        performSegue(withIdentifier:"showDetail", sender:nil);
        tableView.deselectRow(at:indexPath, animated:true);
    }
}
