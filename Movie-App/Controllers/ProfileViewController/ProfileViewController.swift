//
//  ProfileViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/7/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
//    let accountData = AccountData()
    
    var avat: Avatar?
    var movieDB: ImgPath?
    
    // MARK: - UI Components
    
    func makeCircularImageView() {
        screenView.imgView.layer.cornerRadius = screenView.imgView.frame.size.width / 2
        screenView.imgView.layer.masksToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeCircularImageView()
    }
    
    lazy var screenView: ProfileScreen = ProfileScreen()
    
    override func loadView() {
        super.loadView()
        view = screenView
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getAccountDetails()
    }
}

// MARK: - API Call
    
extension ProfileViewController {
    func getAccountDetails() {
//        accountData.getAccountDetail { [weak self] accData in
//            guard let self = self else {return}
//            DispatchQueue.main.async {
//                self.screenView.actualNameLabel.text = accData.name
//                self.screenView.actualUsernameLabel.text = accData.username
//            }
//            avat = accData.avatar
//            movieDB = self.avat?.tmdb
//            if let url = URL(string: "https://image.tmdb.org/t/p/w185\(String(describing: movieDB!.avatarPath))") {
//                DispatchQueue.main.async {
//                    self.screenView.imgView.kf.setImage(with: url)
//                }
//            }
//        } inComplete: { [weak self] error in
//            guard let self = self else {return}
//            
//            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//             self.present(alert, animated: true, completion: nil)
//        }
    }
}
