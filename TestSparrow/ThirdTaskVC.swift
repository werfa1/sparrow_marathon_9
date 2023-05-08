//
//  ViewController.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 05.05.2023.
//

import UIKit

final class ThirdTaskVC: UIViewController {
    
    // MARK: - UI Elements -
    
    private lazy var squareView = UIView()
    private lazy var slider = UISlider()
    
    // MARK: - Fields -
    
    private var propertyAnimator: UIViewPropertyAnimator!
    private var sliderPropertyAnimator: UIViewPropertyAnimator!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: 150, left: 20, bottom: 0, right: 20)
        
        configureSquareView()
        configureSlider()
        
        propertyAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .linear, animations: {
            self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
                .scaledBy(x: 1.5, y: 1.5)
            
            self.squareView.center.x = self.view.frame.maxX - self.view.layoutMargins.right - (self.squareView.frame.width / 2)
        })
        
        sliderPropertyAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            self.slider.value = self.slider.maximumValue
        })
    }
    
    // MARK: - Objective-C Methods -
    
    @objc
    private func handleSliderValueChanged(_ sender: UISlider, for event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                let sliderValue = CGFloat(sender.value)
                animate(forFractureValue: sliderValue)
            default:
                print()
//                sliderPropertyAnimator.startAnimation()
//                animate(forFractureValue: CGFloat(slider.value))
            }
        }
    }
    
    // MARK: - Helpers -
    
    private func animate(forFractureValue value: CGFloat) {
        propertyAnimator.fractionComplete = CGFloat(value)
    }
    
    // MARK: - UI Configuration -
    
    private func configureSquareView() {
        squareView.backgroundColor = .systemPink
        squareView.layer.cornerRadius = 5
        
        view.addSubview(squareView)
        squareView.frame = CGRect(
            x: view.layoutMargins.left,
            y: view.layoutMargins.top,
            width: 100,
            height: 100)
    }
    
    private func configureSlider() {
        slider = UISlider()
        slider.addTarget(self, action: #selector(handleSliderValueChanged), for: .valueChanged)
        slider.tintColor = .systemPink
        slider.thumbTintColor = .systemPink
        view.addSubview(slider)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 50),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

