//
//  ViewController.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 05.05.2023.
//

import UIKit

final class SeventhTaskVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - UI Elements -
    
    private lazy var imageView = UIImageView()
    private lazy var scrollView = UIScrollView()
    private lazy var headerContainerView = UIView()
    private lazy var bottomContainerView = UIView()
    
    // MARK: - Constraints -
    
    private var headerTopConstraint: NSLayoutConstraint!
    private var headerHeightConstraint: NSLayoutConstraint!
        
    // MARK: - Fields -
    
    private let headerHeight: CGFloat = 270
        
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureScrollView()
        configureHeaderContainer()
        configureImageView()
        configureBottomContainer()
    }
    
    // MARK: - Scroll Delegate -
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            headerHeightConstraint?.constant = headerHeight - scrollView.contentOffset.y
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / headerHeight
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant = headerHeight - scrollView.contentOffset.y
            imageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
        }
        if headerHeightConstraint.constant > headerHeight {
            
            // No idea why 60. Found this value experimentally
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: headerHeightConstraint.constant - 60, left: 0, bottom: 0, right: 0)
        } else {
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    // MARK: - UI Configuration -
    
    private func configureScrollView() {
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureHeaderContainer() {
        headerContainerView.clipsToBounds = true
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerTopConstraint = headerContainerView.topAnchor.constraint(equalTo: view.topAnchor)
        headerHeightConstraint = headerContainerView.heightAnchor.constraint(equalToConstant: headerHeight)
        scrollView.addSubview(headerContainerView)
        NSLayoutConstraint.activate([
            headerTopConstraint,
            headerHeightConstraint,
            headerContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureImageView() {
        imageView.image = UIImage(named: "lonely")
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
    }
    
    private func configureBottomContainer() {
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bottomContainerView)
        NSLayoutConstraint.activate([
            bottomContainerView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            bottomContainerView.heightAnchor.constraint(equalToConstant: 1500),
            bottomContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

