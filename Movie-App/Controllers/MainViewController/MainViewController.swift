//
//  MainViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var movieList: [Movie] = [] {
        didSet {
            screenView.tableView.reloadData()
        }
    }
    
    let movieData = MovieData()
    
    // MARK: - UI Components
    
    lazy var screenView: MainScreen = MainScreen()
    
    override func loadView() {
        super.loadView()
        view = screenView
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenView.tableView.delegate = self
        screenView.tableView.dataSource = self
        
        view.backgroundColor = .white
        self.title = "Movie App"
        getPopularMovies()     
    }
}

// MARK: - TableView Data Source

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("The tableView could not deque a custom cell in viewController. ")
        }
        
        let movie = movieList[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Popular Movies"
    }
}

// MARK: - Table View Delegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = movieList[indexPath.row]
        let detailsVC = DetailsViewController(movieId: task.id)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


// MARK: - API Calls

extension MainViewController {
    private func getPopularMovies() {
        movieData.getPopularMovies(success: { [weak self] movieListResult in
            guard let self = self else {return}
            self.movieList = movieListResult.results
        }, failure: { [weak self] error in
            guard let self = self else {return}
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         })
    }
}
