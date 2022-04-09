//
//  OnBoardingViewController.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 06.04.2022.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController {
    
    var pages: [PageModel] = []
    
    var networkDelegate = NetworkDelegate()
    
    let onBoardingCollectionView = UICollectionView(frame: .infinite,
                                                    collectionViewLayout: UICollectionViewLayout.init())
    let nextButton = UIButton()
    let pageControl = UIPageControl()
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        onBoardingCollectionView.dataSource = self
        onBoardingCollectionView.delegate = self
        
        initializate()
        setupConstraints()
    }
    
    private func initializate() {
        pages = PageModel.getPages()
        
        view.backgroundColor = .white
        view.addSubview(onBoardingCollectionView)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        
        onBoardingCollectionView.register(OnBoardingViewCell.self,
                                         forCellWithReuseIdentifier: "OnBoardingViewCell")
        onBoardingCollectionView.reloadData()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        onBoardingCollectionView.collectionViewLayout = flowLayout
        onBoardingCollectionView.showsHorizontalScrollIndicator = false
        onBoardingCollectionView.showsVerticalScrollIndicator = false
        onBoardingCollectionView.isPagingEnabled = true
        
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .yellow
        pageControl.isEnabled = false
        
        nextButton.backgroundColor = .darkGray
        nextButton.layer.cornerRadius = 10
        nextButton.setTitle("Next", for: .normal)
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(nextButtonPressed),
                             for: .touchUpInside)
    }
    
    private func setupConstraints() {
        onBoardingCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).offset(-30)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-25)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

//MARK: -UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "OnBoardingViewCell",
                                 for: indexPath) as? OnBoardingViewCell
        else { return UICollectionViewCell() }
        let isLargeScreen = isLargeScreen(frame: UIScreen.main.bounds)
        
        cell.setupOnBoardingCell(pages[indexPath.item],
        isLargeScreen: isLargeScreen)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = UIScreen.main.bounds.height
        let isLargeScreen = self
            .isLargeScreen(frame: UIScreen.main.bounds)
        return CGSize(width: (UIScreen.main.bounds.width - 10),
                      height: isLargeScreen ?
                          (height * 0.75) : (height * 0.65))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        case 0:
            nextButton.setTitle("Get started!", for: .normal)
            pageControl.currentPage = 1
            nextButton.addTarget(self,
                                 action: #selector(getStartedButtonPressed),
                                 for: .touchUpInside)
        case 1:
            nextButton.setTitle("Next", for: .normal)
            pageControl.currentPage = 0
            nextButton.removeTarget(self,
                                    action: #selector(getStartedButtonPressed),
                                    for: .touchUpInside)
            nextButton.addTarget(self,
                                 action: #selector(nextButtonPressed),
                                 for: .touchUpInside)
        default:
            break
        }
    }
}

//MARK: -Methods
extension OnBoardingViewController {
    @objc private func nextButtonPressed() {
        scrollToItem(indexPath: IndexPath(item: 1,
                                          section: 0))
    }
    
    @objc private func getStartedButtonPressed() {
        let userLoginVC = UserLoginViewController()
        userLoginVC.networkDelegate = self.networkDelegate
        self.navigationController?.pushViewController(userLoginVC,
                                                      animated: true)
    }
    
     private func scrollToItem(indexPath: IndexPath) {
         onBoardingCollectionView.isPagingEnabled = false
         onBoardingCollectionView.scrollToItem(at: indexPath,
                                               at: .centeredHorizontally,
                                               animated: true)
         onBoardingCollectionView.isPagingEnabled = true
    }
    
    fileprivate func isLargeScreen(frame: CGRect) -> Bool {
        return frame.size.height > 670 ? true : false
    }
}
