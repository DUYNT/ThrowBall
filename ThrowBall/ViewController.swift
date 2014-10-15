//
//  ViewController.swift
//  ThrowBall
//
//  Created by DuyNT on 10/8/14.
//  Copyright (c) 2014 DuyNT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var ball: UIImageView?
    var target: UIImageView?
    var cotdoc1: UIView!
    var cotdoc2: UIView!
    var thumon: UIView?
    var count: UILabel!
    
    var cungThanh: UIView!
    var vX: Double = 0.0
    var vY: Double = 0.0
    var xR: Double = 0.0
    var YR: Double = 0.0
    var width: Double = 0.0
    var height: Double = 0.0
    var R = 15.0 //radius of ball
    var timer: NSTimer?
    var cong: Int = 0
    var cong2: Int = 0
    override func loadView() {
        super.loadView()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        let size = self.view.bounds.size
        width = Double(size.width)
        height = Double(size.height) - 60
        cungThanh = UIView(frame: CGRect(x: 0, y: 0, width: size.width * 0.55, height: 30))
        cungThanh.center = CGPoint(x: size.width * 0.5, y: 0)
        cungThanh.backgroundColor = UIColor.blueColor()
        self.view.addSubview(cungThanh)
        
        cotdoc1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 100))
        cotdoc1.center = CGPoint(x: size.width * 0.24, y: size.height * 0.1)
        cotdoc1.backgroundColor = UIColor.blueColor()
        self.view.addSubview(cotdoc1)
        
        cotdoc2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 100))
        cotdoc2.center = CGPoint(x: size.width * 0.76, y: size.height * 0.1)
        cotdoc2.backgroundColor = UIColor.blueColor()
        self.view.addSubview(cotdoc2)
        
        count = UILabel(frame: CGRect(x: size.width * 0.8, y: size.height * 0.8, width: 40, height: 60))
        count?.font = UIFont.systemFontOfSize(40)
        count?.text = "0"
        self.view.addSubview(count!)
        
        ball = UIImageView(image: UIImage(named: "football.png"))
        ball?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        ball?.center = CGPoint(x: size.width * 0.5, y: size.height * 0.85)
        self.view.addSubview(ball!)
        
        
        ball!.multipleTouchEnabled = true
        ball!.userInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self, action: "panIt:")
        ball?.addGestureRecognizer(pan)
        
        thumon = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 10))
        thumon?.center = CGPoint(x: (size.width * 0.5) - 15, y: size.height * 0.180)
        thumon?.backgroundColor = UIColor.brownColor()
        self.view.addSubview(thumon!)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "loop:", userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func panIt(pan: UIPanGestureRecognizer) {
        if (pan.state == UIGestureRecognizerState.Began || pan.state == UIGestureRecognizerState.Changed) {
            let velocity = pan.velocityInView(self.view)
            vX += Double(velocity.x) * 5 / width
            vY += Double(velocity.y) * 5 / height
        }
    }
    
    func loop(timer: NSTimer) {
        var x1 = Double(ball!.center.x) + vX
        var y1 = Double(ball!.center.y) + vY
        let size = self.view.bounds.size
        let cot1x = size.width * 0.24
        let coty = size.height * 0.23
        let cot2x = size.width * 0.76
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        
        
        if x1 < R {
            x1 = R
            vX = -vX
        }
        if x1 > width - R {
            x1 = width - R
            vX = -vX
        }
        
        if y1 < R {
            y1 = R
            vY = -vY
        }
        if y1 > height - R {
            y1 = height - R
            vY = -vY
        }
        ball!.center = CGPoint(x: x1, y: y1)
        vX = 0.9 * vX
        vY = 0.9 * vY
        
        if ball!.center.x != size.width * 0.5{
            let randomNum = Int(arc4random_uniform(UInt32(90)))
            let randomNum2 = Int(arc4random_uniform(UInt32(72)))
            
            if (thumon!.center.x == (size.width * 0.5) - 15) | (thumon!.center.y == size.height * 0.180){
                thumon?.center = CGPoint(x: (size.width * 0.5) - (CGFloat(randomNum) - CGFloat(randomNum2)), y: size.height * 0.180)
            }
        }
        if ball!.center.x - 15 > cot1x && ball!.center.x < cot2x && ball!.center.y + 15 < coty{
            if CGRectIntersectsRect(ball!.frame, cotdoc1!.frame) || CGRectIntersectsRect(ball!.frame, cotdoc2!.frame) || CGRectIntersectsRect(ball!.frame, cungThanh!.frame){
                ball?.center = CGPoint(x: size.width * 0.5, y: size.height - 30)
                count!.text = NSString(format: "%d", cong++)
            }
        }
        if ball!.center.x < cot1x || ball!.center.x > cot2x {
            if CGRectIntersectsRect(ball!.frame, cotdoc1!.frame) || CGRectIntersectsRect(ball!.frame, cotdoc2!.frame){
                ball?.center = CGPoint(x: size.width * 0.5, y: size.height - 30)
            }
        }
        if CGRectIntersectsRect(ball!.frame, thumon!.frame){
            let button = UIAlertView(title: "Fail", message: "Game Over", delegate: self.navigationController?.popToRootViewControllerAnimated(true), cancelButtonTitle: "OK")
            button.show()
            timer.invalidate()
        }
    }
    
    func nextTimer(){
        let size = self.view.bounds.size
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if CGRectIntersectsRect(ball!.frame, thumon!.frame){
            ball?.removeFromSuperview()
        }
        timer?.invalidate()
        timer = nil
    }
}
