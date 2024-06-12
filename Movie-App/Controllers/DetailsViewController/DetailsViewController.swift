//
//  DetailsViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/7/24.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var movieCast: [Cast] = [] {
        didSet {
            screenView.collectionView.reloadData()
        }
    }
    
    var spokenLanguage: [Language] = []
    
    let movieData = MovieData()
//    let castDetails = CastDetails()
    
    private var movieId: Int
    
    init (movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    lazy var screenView: DetailsScreen = DetailsScreen()
    
    override func loadView() {
        super.loadView()
        view = screenView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenView.collectionView.dataSource = self
        screenView.collectionView.delegate = self
        screenView.backgroundColor  = .white
        getMovieDetails()
        getCastDetails()
    }
}

// MARK: - UICollectionView DataSource

extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCast.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCell.identifier,
            for: indexPath) as? CollectionCell else {
            
            fatalError("The collectionView could not deque a custom cell in viewController. ")
        }
        
        let cast = movieCast[indexPath.item]
        
        cell.configureWith(with: cast)
        return cell
    }
}

// MARK: - UICollectionView Delegate

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        return CGSize(width: 70, height: 150)
    }
}

// MARK: - API Calls

extension DetailsViewController {
    
    // MARK: - Movie Details API Call
    
    func getMovieDetails() {
        
        Task {
            do {
                let details = try await MovieData().load(Language.movieDetailById(id: movieId))
                screenView.titleLabel.text = details.title
                screenView.descriptionLabel.text = details.overview
                screenView.actualRuntimeLabel.text = "\(details.runtime)"
                spokenLanguage = details.spokenLanguages
                for language in self.spokenLanguage {
                    screenView.actualLanguageLabel.text = "\(language.englishName)"
                }
                if let url = URL(string: "https://image.tmdb.org/t/p/original\(details.posterPath)") {
                    DispatchQueue.main.async {
                        self.screenView.imgView.kf.setImage(with: url)
                    }
                }
            } catch {
                print("Error loading popular movies: \(error)")
            }
        }
    }
    
    // MARK: - Cast Details API Call
    
    func getCastDetails() {
        Task {
            do {
                let cast = try await MovieData().load(Cast.getCastById(idNum: movieId))
                movieCast = cast.cast
            } catch {
                print("Error loading cast details: \(error)")
            }
        }
    }
    
}
