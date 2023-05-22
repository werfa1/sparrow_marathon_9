//
//  ViewController.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 05.05.2023.
//

import UIKit

final class EighthTaskVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - UI Elements -
    
    private lazy var scrollView = UIScrollView()
    private var imageView: UIImageView!
        
    // MARK: - Fields -
            
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Avatar"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavBar()
        configureScrollView()
    }
    
    // MARK: - Scroll Delegate -
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navigationController else { return }
//        if navigationController.navigationBar.frame.height <= (44 + 5) {
//            imageView.isHidden = true
//        } else {
//            imageView.isHidden = false
//        }
        print()
    }
        
    // MARK: - UI Configuration -
    
    private func configureNavBar() {
        guard let navigationController else { return }
        imageView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        navigationController.navigationBar.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 36),
            imageView.heightAnchor.constraint(equalToConstant: 36),
            imageView.trailingAnchor.constraint(equalTo: navigationController.navigationBar.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor, constant: -8)
        ])
    }
    
    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

