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
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    //* MARK:  Variables
    var viewModel: ImageListViewModel!
    let apiService = APIService()
    
    //* MARK: Constant
    let imageListCollectionViewCellIdentifier: String = "ImageListCollectionViewCell"
    
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
        navigationItem.title = "Gallery"
        
        /// Register collection view
        photoCollectionView.register(
            UINib(nibName: imageListCollectionViewCellIdentifier, bundle: Bundle.main),
            forCellWithReuseIdentifier: imageListCollectionViewCellIdentifier
        )
    }
    
    func setupObserver() {
        /// Bind data to collection view
        viewModel.imageList.bind(to: photoCollectionView.rx.items(cellIdentifier: imageListCollectionViewCellIdentifier, cellType: ImageListCollectionViewCell.self)) { row, item, cell in
            cell.setupView(imageUrl: item.download_url)
        }.disposed(by: disposeBag)
        
        photoCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        /// Image selected
        photoCollectionView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if let vc = UIStoryboard.init(name: "ImageDetail", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController {
                    vc.imageItem = self.viewModel.imageList.value[indexPath.row]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension ImageListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 20) / 3
        let cellHeight = cellWidth
       
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
