//  MovieDetailViewController.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - UI elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var watchlistBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    // MARK: - Properties NOTE SYNTAX
    var movie: Movie!;
    var isWatchlist: Bool {return MovieModel.watchlist.contains(movie);}
    var isFavorite: Bool {return MovieModel.favorites.contains(movie);}
    
    // MARK: - Overrides & Actions
    override func viewDidLoad() {
        super.viewDidLoad();
        
        navigationItem.title = movie.title;
        
        toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist);
        toggleBarButton(favoriteBarButtonItem, enabled: isFavorite);
    }
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        //TODO:
        TMDBClient.markWatchlist(movieId:movie.id, watchlist:!isWatchlist, completion:handleWatchlistResponse(success:error:));
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        //TODO:
    }
    
    
    // MARK: - Helper functions & completion handlers/callbacks
    func toggleBarButton(_ button:UIBarButtonItem, enabled:Bool) {
        // Helper method to control UI
        if enabled {
            button.tintColor = UIColor.primaryDark;
        } else {
            button.tintColor = UIColor.gray;
        }
    }
    
    func handleWatchlistResponse(success:Bool, error:Error?) {
        // Callback/completion handler for TMDBClient.markWatchlist()
        // NOTE: the logic, not implementation, is more important here
        if success {
            if isWatchlist {
                // If movie on watchlist, it means we succesfully deleted it
                MovieModel.watchlist = MovieModel.watchlist.filter() {$0 != self.movie;}
            } else {
                // If not on watchlist, it means we successfully added it
                MovieModel.watchlist.append(movie);
            }
            
            // Update UI:
            toggleBarButton(watchlistBarButtonItem, enabled:isWatchlist);
        } else {
            print("ERROR: Failed to callback handleWatchlistResponse()!");
        }
    }
    
    
}
