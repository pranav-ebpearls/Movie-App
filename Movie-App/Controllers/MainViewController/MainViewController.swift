//
//  MainViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var nowShowingMovies: [Movie] = [] {
        didSet {
            screenView.tableView.reloadData()
        }
    }
    
    private var popularMovies: [Movie] = [] {
        didSet {
            screenView.tableView.reloadData()
        }
    }
    
    var totalPage = 1
    var currentPage = 1
    
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
        getPopularMovies(pageNumber: 1)
        getNowShowingMovies()
    }
}

// MARK: - TableView Data Source

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if nowShowingMovies.count > 0 {
                return 1
            } else {
                return 0
            }
        } else {
            
            return popularMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CustomCollectinCell.identifier,
                for: indexPath) as? CustomCollectinCell else {
                    
                fatalError("The collectionView could not deque a custom cell in viewController. ")
            }
            cell.parentViewController = self
            cell.popularMovies = nowShowingMovies
            
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CustomCell.identifier,
                for: indexPath) as? CustomCell else {
                
                fatalError("The tableView could not deque a custom cell in viewController. ")
            }
            let movie = popularMovies[indexPath.row]
            cell.configure(with: movie)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentPage < totalPage && indexPath.row == popularMovies.count - 1 {
            currentPage += 1
            getPopularMovies(pageNumber: currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Now Showing Movies"
        } else {
            return "Popular Movies"
        }
    }
}

// MARK: - Table View Delegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let task = nowShowingMovies[indexPath.row]
            let detailsVC = DetailsViewController(movieId: task.id)
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            let task = popularMovies[indexPath.row]
            let detailsVC = DetailsViewController(movieId: task.id)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 315
        } else {
            return 170
        }
    }
}

// MARK: - API Calls

extension MainViewController {
    private func getPopularMovies(pageNumber: Int) {
        Task {
            do {
                let popular = try await MovieData().load(Movie.popular(pageNo: pageNumber))
                popularMovies.append(contentsOf: popular.results)
                totalPage = popular.totalPages ?? 1
            } catch {
                print("Error loading popular movies: \(error)")
            }

//            do {
//                let result = try await movieData.newload(Movie.popular(pageNo: pageNumber))
//                
//                switch result {
//                    
//                case .success(let popular):
//                    popularMovies.append(contentsOf: popular.results)
//                    totalPage = popular.totalPages ?? 1
//                    
//                case .failure(let error):
//                    print("Error loading popular movies: \(error)")
//                }
//            } catch {
//                print("Error loading popular movies: \(error)")
//            }
        }
    }
    
    private func getNowShowingMovies() {
        Task {
            do {
                let nowShowing = try await MovieData().load(Movie.nowShowing)
                nowShowingMovies = nowShowing.results
            } catch {
                print("Error loading popular movies: \(error)")
            }
        }
    }
}
