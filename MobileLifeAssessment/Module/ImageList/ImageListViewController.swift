//
//  ImageListViewController.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import UIKit
import RxSwift

class ImageListViewController: UIViewController {
    
    //* MARK: - IBOutlet
    
    /// Variables
    var viewModel: ImageListViewModel!
    let apiService = APIService()
    
    
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    //* MARK: -  LifeCycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ImageListViewModel(apiService: apiService, parentViewController: self)
        
        configureViews()
        setupObserver()
        
        self.viewModel.getImageList(pageNo: 1)
    }
    
    
    //* MARK: - Helper
    /// Set up view
    func configureViews() {
        navigationItem.title = "Photos"
        
    }
    
    func setupObserver() {
    }
}
