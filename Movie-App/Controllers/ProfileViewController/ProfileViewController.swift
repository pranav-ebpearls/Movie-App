//
//  ProfileViewController.swift
//  Movie-App
//
//  Created by ebpearls on 6/7/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
        
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
//        getAccountDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAccountDetails()
    }
}

// MARK: - API Call
    
extension ProfileViewController {
    func getAccountDetails() {
        Task {
            do {
                let account = try await MovieData().load(ImgPath.account)
                screenView.actualNameLabel.text = account.name
                screenView.actualUsernameLabel.text = account.username
                avat = account.avatar
                movieDB = avat?.tmdb
                if let url = URL(string: "https://image.tmdb.org/t/p/w185\(String(describing: movieDB!.avatarPath)))") {
                    DispatchQueue.main.async {
                        self.screenView.imgView.kf.setImage(with: url)
                    }
                }
            } catch {
                print("Error loading account details: \(error)")
            }
        }
    }
}
