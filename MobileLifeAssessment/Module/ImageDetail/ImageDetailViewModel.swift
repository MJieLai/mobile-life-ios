//
//  ImageDetailViewModel.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ImageDetailViewModel: NSObject {
    
    /// API Service
    let apiService: APIService
    
    let disposeBag = DisposeBag()
    let parentViewController: ImageDetailViewController
    
    /// Input
    
    
    /// Variables
    
    
    init(apiService: APIService, parentViewController: ImageDetailViewController) {
        self.apiService = apiService
        self.parentViewController = parentViewController

        super.init()
        
        setupObserver()
    }
    
    private func setupObserver() {
        
    }
}

//* MARK: - API
extension ImageDetailViewModel {
    //* MARK:
    
}
