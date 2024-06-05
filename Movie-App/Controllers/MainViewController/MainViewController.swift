//
//  MainViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import UIKit

class MainViewController: UIViewController {
    private var movieList: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let movieData = MovieData()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        
        view.backgroundColor = .white
        self.title = "Movie App"

        setupUI()
        
        
//        movieData.completeURL()
//        
//        movieData.jsonDataClosure = { [weak self] title in
//            guard let self = self else {return}
//            self.contents.append(title)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//            
//        }
        
        getPopularMovies()
        
        
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

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
