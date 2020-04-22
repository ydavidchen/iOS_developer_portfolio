//  WatchlistViewController.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import UIKit;

class WatchlistViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!;
    var selectedIndex = 0;
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad();
        
        _ = TMDBClient.getWatchlist() { (movies,error) in
            MovieModel.watchlist = movies;
            self.tableView.reloadData();
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController;
            detailVC.movie = MovieModel.watchlist[selectedIndex];
        }
    }
    
}


/*
Extension: TableView delegates & DataSource methods implementation
*/
extension WatchlistViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView:UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return MovieModel.watchlist.count;
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!;
        let movie = MovieModel.watchlist[indexPath.row];
        cell.textLabel?.text = movie.title;
        
        // Display image in table (not all images are downloaded once; instead, reusable cell):
        if let posterPath = movie.posterPath {
            // Perform download within ... (do SAME for favourites)
            TMDBClient.downloadPosterImage(path:posterPath) {(data,error) in
                guard let data = data else {
                    return;
                }
                let image = UIImage(data:data);
                cell.imageView?.image = image;
                cell.setNeedsLayout(); //refresh cell
            }
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row;
        performSegue(withIdentifier:"showDetail", sender:nil);
        tableView.deselectRow(at:indexPath, animated:true);
    }
}
