//
//  ViewController.swift
//  bulleyes
//
//  Created by 王玉钰 on 2017/4/5.
//  Copyright © 2017年 王玉钰. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var currentValue: Int = 50
    var targetValue: Int = 0
    var scoreValue: Int = 0
    var roundValue: Int = 0
    
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sliderModification()
        currentValue = lroundf(slider.value)
        targetValue = 1 + Int(arc4random_uniform(100))
        self.startNewRound()
        self.updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateLabels() -> Void {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
    }
    
    func startNewRound() -> Void {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        roundValue += 1
        
        
    }
    
    @IBAction func showAlert() {
        let difference = abs(currentValue-targetValue);
        let point = 100 - difference
        let title : String
        scoreValue += point
        
        if difference == 0 {
            title = "perfect"
        }else if difference<5{
            title = "You almost had it"
        }else{
            title = "Not even close"
        }
        
        
        let message = "The value of the slider is now :\(currentValue)\n" +
                      "The target value is : \(targetValue)\n" +
                      "The difference is \(difference) \n" +
                      "You have got \(point) points"
        
        
        
        
        
        let alert = UIAlertController(title: "Hello, World",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .default,
                                   handler: {action in
                                    self.startNewRound()
                                    self.updateLabels()})

        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        startNewRound()
//        updateLabels()
        
    }
    
    func startNewGame() -> Void {
        scoreValue = 0;
        roundValue = 0;
        startNewRound();
    }
    
    @IBAction func sliderMoved(_ slider:UISlider){
        currentValue = lroundf(slider.value)
        print("The value of the slider is now : \(slider.value)")
    }
    
    @IBAction func startOver(){
        
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
        
        
    }
    
    func sliderModification() -> Void {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlight = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlight, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)    }
}

