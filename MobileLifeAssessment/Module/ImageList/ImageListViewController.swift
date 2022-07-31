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
    /// Pagination
    var pageNo: Int = 0
    var isPageRefreshing:Bool = false
    
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
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        if #available(iOS 10, *) {
            photoCollectionView.refreshControl = refreshControl
        } else {
            photoCollectionView.addSubview(refreshControl)
        }
    }
    
    func setupObserver() {
        /// Bind data to collection view
        viewModel.allImageList.bind(to: photoCollectionView.rx.items(cellIdentifier: imageListCollectionViewCellIdentifier, cellType: ImageListCollectionViewCell.self)) { row, item, cell in
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
                    vc.imageItem = self.viewModel.allImageList.value[indexPath.row]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        /// Refresh control set up
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.getImageList(pageNo: 1)
                self.pageNo = 1
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .map { _ in self.refreshControl.isRefreshing }
            .filter { $0 == true }
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
}

extension ImageListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 20) / 3
        let cellHeight = cellWidth
       
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.photoCollectionView.contentOffset.y >= (self.photoCollectionView.contentSize.height - self.photoCollectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pageNo = pageNo + 1
                self.viewModel.getImageList(pageNo: pageNo)
            }
        }
    }
}
