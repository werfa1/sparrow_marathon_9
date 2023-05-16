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
    
    private lazy var dynamicAnimator = UIDynamicAnimator(referenceView: view)
    
    private lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior(items: [squareView])
        behavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(behavior)
        return behavior
    }()
    
    private var snapBehavior: UISnapBehavior!
        
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
            snapBehavior.snapPoint = coordinates
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
        collisionBehavior.addItem(squareView)
        let snap = UISnapBehavior(item: squareView, snapTo: view.center)
        snap.damping = 1
        dynamicAnimator.addBehavior(snap)
        snapBehavior = snap
    }
}

