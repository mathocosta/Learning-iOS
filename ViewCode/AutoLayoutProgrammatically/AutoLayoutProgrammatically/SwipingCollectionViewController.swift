//
//  SwipingCollectionViewController.swift
//  AutoLayoutProgrammatically
//
//  Created by Matheus Oliveira Costa on 29/06/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit

final class SwipingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    private let reuseIdentifier = "Cell"
    
    let viewModel: SwipingCollectionViewModel
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onPreviousButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onNextButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .gray
        
        return pageControl
    }()
    
    lazy var bottomControlsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.previousButton, self.pageControl, self.nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // MARK: Lifecycle
    init(collectionViewLayout layout: UICollectionViewLayout, viewModel: SwipingCollectionViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.backgroundColor = .white
        self.collectionView?.register(SwipingCollectionViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        self.collectionView.isPagingEnabled = true
        
        self.setupView()
    }
    
    // MARK: Actions
    @objc func onPreviousButton(sender: UIButton) {
        let prevItem = max(self.pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevItem, section: 0)
        self.pageControl.currentPage = prevItem
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func onNextButton(sender: UIButton) {
        let nextItem = min(self.pageControl.currentPage + 1, self.viewModel.pages.count - 1)
        let indexPath = IndexPath(item: nextItem, section: 0)
        self.pageControl.currentPage = nextItem
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.pages.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier,
                                                            for: indexPath) as? SwipingCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of ContactListTableViewCell.")
        }
        
        let currentPage = self.viewModel.pages[indexPath.item]
        let cellViewModel = SwipingCollectionViewCellViewModel(page: currentPage)
        cell.viewModel = cellViewModel
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // UIScrollViewDelegate
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                            withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        self.pageControl.currentPage = Int(x / view.frame.width)
    }
    
}

extension SwipingCollectionViewController: CodeView {
    
    func buildViewHierarchy() {
        self.view.addSubview(self.bottomControlsStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.bottomControlsStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.bottomControlsStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.bottomControlsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupAdditionalConfiguration() {
    }
    
}
