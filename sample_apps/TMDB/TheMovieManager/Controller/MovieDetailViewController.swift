//  MovieDetailViewController.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import UIKit;

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
        
        toggleBarButton(watchlistBarButtonItem, enabled:isWatchlist);
        toggleBarButton(favoriteBarButtonItem, enabled:isFavorite);
        
        // Note how associated value, posterPath, is created!
        if let posterPath = movie.posterPath {
            TMDBClient.downloadPosterImage(path:posterPath) {(data,error) in
                guard let data = data else {
                    return;
                }
                
                // Set image:
                let image = UIImage(data:data);
                self.imageView.image = image;
            }
        }
    }
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markWatchlist(movieId:movie.id, watchlist:!isWatchlist, completion:handleWatchlistResponse(success:error:));
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markFavourites(movieId:movie.id, isFavourite:!isFavorite, completion:handleFavouritesResponse(success:error:));
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
        if success {
            print("DEBUG: handleWatchlistResponse() successfully called!");
            if isWatchlist {
                MovieModel.watchlist = MovieModel.watchlist.filter() {$0 != self.movie;}
            } else {
                MovieModel.watchlist.append(movie);
            }
            
            toggleBarButton(watchlistBarButtonItem, enabled:isWatchlist); //Updates UI
        } else {
            print("ERROR: Failed to callback handleWatchlistResponse()!");
        }
    }
    
    func handleFavouritesResponse(success:Bool, error:Error?) {
        if success {
            if isFavorite {
                print("Do something");
                MovieModel.favorites = MovieModel.favorites.filter() {$0 != self.movie;}
            } else {
                MovieModel.favorites.append(movie);
            }
            toggleBarButton(favoriteBarButtonItem, enabled:isFavorite); //Updates UI
        }
    }
    
}
