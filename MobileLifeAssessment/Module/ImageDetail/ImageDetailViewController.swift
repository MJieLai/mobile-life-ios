//
//  ImageDetailViewController.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import UIKit
import RxSwift

class ImageDetailViewController: UIViewController {
    
    //* MARK: - IBOutlet
    
    /// Variables
    var viewModel: ImageDetailViewModel!
    let apiService = APIService()
    
    
    private let disposeBag = DisposeBag()
    
    //* MARK: -  LifeCycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ImageDetailViewModel(apiService: apiService, parentViewController: self)
        
        configureViews()
        setupObserver()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }
    
    //* MARK: - Helper
    /// Set up view
    func configureViews() {
        navigationItem.title = "Photos"
        
        
    }
    
    func setupObserver() {
    }
}

