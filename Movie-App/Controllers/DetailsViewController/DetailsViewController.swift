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
    
    var movieCast: [Cast] = []{
        didSet {
            screenView.collectionView.reloadData()
        }
    }
    
    var spokenLanguage: [Language] = []
    
    let movieData = MovieData()
    let castDetails = CastDetails()
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {
            fatalError("The collectionView could not deque a custom cell in viewController. ")
        }
        
        let cast = movieCast[indexPath.item]
        
        cell.configureWith(with: cast)
        return cell
    }
}

// MARK: - UICollectionView Delegate

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 150)
    }
}

// MARK: - API Calls

extension DetailsViewController {
    
    // MARK: - Movie Details API Call
    
    func getMovieDetails() {
        movieData.getMovieDetail(movieId: movieId) { [weak self] movieDetailResult in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.screenView.titleLabel.text = movieDetailResult.title
                self.screenView.descriptionLabel.text = movieDetailResult.overview
                self.screenView.actualRuntimeLabel.text = "\(movieDetailResult.runtime) min"
                self.spokenLanguage = movieDetailResult.spokenLanguages
                for mo in self.spokenLanguage {
                    self.screenView.actualLanguageLabel.text = "\(mo.englishName)"
                }
                
//                convert array into string
//                component separator
//                "Nepali, English, Germany"
            }
            if let url = URL(string: "https://image.tmdb.org/t/p/original\(movieDetailResult.posterPath)"){
                DispatchQueue.main.async {
                    self.screenView.imgView.kf.setImage(with: url)
                }
            }
            
        } notSuccessful: { [weak self] error in
            guard let self = self else {return}
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Cast Details API Call
    
    func getCastDetails() {
        castDetails.getCastDetails(movieId: movieId) { [weak self] castList in
            if let self = self {
                self.movieCast = castList.cast
            }
        } fail: { [weak self] error in
            guard let self = self else {return}
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
        }

    }
    
}

