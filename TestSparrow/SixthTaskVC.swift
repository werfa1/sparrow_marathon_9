//
//  ViewController.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 05.05.2023.
//

import UIKit

final class SixthTaskVC: UIViewController {
    
    // MARK: - UI Elements -
    
    private lazy var squareView = UIView()
        
    // MARK: - Fields -
        
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSquareView()
    }
    
    // MARK: - Objective-C Methods -
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let coordinates = touch.location(in: view)
            let translationX = coordinates.x - squareView.center.x
            let translationY = coordinates.y - squareView.center.y
            UIView.animate(withDuration: 0.3) {
                self.squareView.transform = .init(translationX: translationX, y: translationY)
            }
        }
    }
    
    // MARK: - Popover Delegate -
    
    // MARK: - UI Configuration -
    
    private func configureSquareView() {
        squareView.backgroundColor = .systemPink
        squareView.layer.cornerRadius = 5
        
        view.addSubview(squareView)
        squareView.frame = CGRect(
            x: view.frame.midX,
            y: view.frame.midY,
            width: 100,
            height: 100)
        squareView.center = view.center
    }
}

