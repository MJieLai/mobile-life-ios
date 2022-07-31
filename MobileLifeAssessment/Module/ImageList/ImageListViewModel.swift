//
//  ImageListViewModel.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
//import SwiftyUserDefaults

class ImageListViewModel: NSObject {
    
    /// API Service
    let apiService: APIService
    
    let disposeBag = DisposeBag()
    let parentViewController: ImageListViewController
    
    /// Input
    let imageList: BehaviorRelay<[ImageItem]> = BehaviorRelay(value: [])
   
    /// Variables
    var selectedImage: Driver<ImageItem> = .never()
    
    init(apiService: APIService, parentViewController: ImageListViewController) {
        self.apiService = apiService
        self.parentViewController = parentViewController

        super.init()
        
        setupObserver()
    }
    
    private func setupObserver() {

    }
}

//* MARK: - API
extension ImageListViewModel {
    //* MARK: GetImageList
    func getImageList(pageNo: Int) {
        let spinner = self.parentViewController.showLoader(view: self.parentViewController.view, isIgnoreInteraction: false)
        
        self.getImageList(pageNo: pageNo) { response in
            switch response {
            case .success(let value):
                self.imageList.accept(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
            spinner.dismissLoader()
        }
    }
    
    func getImageList(pageNo: Int, completionHandler: @escaping(Result<[ImageItem], Error>) -> Void){
        apiService.getImageList(page: pageNo) { response in
            switch response {
            case .success(let value):
                DispatchQueue.main.async {
                    completionHandler(.success(value))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}


