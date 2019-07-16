//
//  ViewController.swift
//  Lottie Showcase
//
//  Created by Stephen Wilson on 15/07/2019.
//  Copyright © 2019 Stephen Wilson. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    //let animations: [String] = ["2837-trophy-animation", "balls-loading", "card_animation", "checked_done_", "done_button", "done", "green-tick", "loader-bad", "loader-ok", "loading_tick_1", "loading-tick-blue", "success-tick", "trophy-circle", "trophy"]
    let animations = ["3168-passport", "4975-question-mark", "success-tick", "loader-bad", "green-tick"]
    
    var currentIndex = 0
    var lottie: AnimationView?
    lazy var label = UILabel(frame: CGRect(x: 0, y: 30, width: view.bounds.size.width, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.textAlignment = .center
        view.addSubview(label)
        
        let swipeRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(sender:)))
        swipeRecogniser.direction = .right
        view.addGestureRecognizer(swipeRecogniser)
        
        let swipeLeftRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(sender:)))
        swipeLeftRecogniser.direction = .left
        view.addGestureRecognizer(swipeLeftRecogniser)
        
        loadLottie(atIndex: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lottie?.play()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        lottie?.play()
    }
    
    func loadLottie(atIndex index: Int) {
        print(index)
        guard index >= 0, index < animations.count else { return }
        currentIndex = index
        
        let animationName = animations[index]
        label.text = animationName
        
        let lottieView = AnimationView()
        let animation = Animation.named(animationName)
        lottieView.animation = animation
        lottieView.currentProgress = 0
        lottieView.animationSpeed = 1
        lottieView.isHidden = false
        lottieView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lottieView.contentMode = .scaleAspectFit
        lottieView.frame = view.bounds
        lottieView.isUserInteractionEnabled = false
        view.insertSubview(lottieView, at: 0)
        
        if let lottie = lottie {
            lottie.removeFromSuperview()
        }
        lottie = lottieView
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer) {
        var nextIndex = currentIndex + 1
        if nextIndex >= animations.count {
            nextIndex = 0
        }
        loadLottie(atIndex: nextIndex)
        lottie?.play()
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer) {
        var nextIndex = currentIndex - 1
        if nextIndex < 0 {
            nextIndex = animations.count - 1
        }
        loadLottie(atIndex: nextIndex)
        lottie?.play()
    }
}

