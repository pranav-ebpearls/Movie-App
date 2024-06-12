//
//  CustomCollectinCell.swift
//  Movie-App
//
//  Created by ebpearls on 6/11/24.
//

import UIKit

class CustomCollectinCell: UITableViewCell {
    
    static let identifier = "CustomCollectionCell"
    
    var popularMovies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var parentViewController: UIViewController?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 220),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

extension CustomCollectinCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularMovies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.identifier,
            for: indexPath) as? CollectionViewCell else {
            
            fatalError("The collectionView could not deque a custom cell in viewController. ")
        }
        
        let popular = popularMovies[indexPath.row]
        
        cell.apiCall(with: popular)
        
        return cell
    }
}

extension CustomCollectinCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let task = popularMovies[indexPath.row]
        let detailViewController = DetailsViewController(movieId: task.id)
        parentViewController?.navigationController?.pushViewController(detailViewController, animated: true)
        }
}

extension CustomCollectinCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        return CGSize(width: 160, height: 330)
    }
}
