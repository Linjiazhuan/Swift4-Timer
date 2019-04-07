//
//  ViewController.swift
//  Timer
//
//  Created by 林佳傳 on 2019/4/7.
//  Copyright © 2019 jiazhuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!{
        didSet{
            self.startButton.layer.cornerRadius = self.startButton.frame.height / 2
            self.startButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var resetButton: UIButton!{
        didSet{
            self.resetButton.isHidden = true
            self.resetButton.layer.cornerRadius = self.resetButton.frame.height / 2
            self.resetButton.layer.masksToBounds = true
        }
    }
    //使用Timer
    var timer:Timer?
    //記錄碼表的狀態
    var timerState:Bool = false
    var elapsedTimeInscond:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startTimer(){
        if timerState == false{
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                self.elapsedTimeInscond += 1
                self.updateTimeLabel()
            })
            timerState = true
            startButton.setTitle("停止", for: .normal)
            updateTimeLabel()
            resetButton.isHidden = false
        }else{
            startButton.setTitle("繼續", for: .normal)
            timerState = false
            stopTimer()
        }
    }

    
    func stopTimer(){
        timer?.invalidate()
    }

    func updateTimeLabel(){
        let second = elapsedTimeInscond % 60
        let minute = (elapsedTimeInscond / 60) % 60
        let hour = ((elapsedTimeInscond / 60) / 60) % 60
        timeLabel.text = String(format: "%02d:%02d:%02d",hour, minute, second)
    }
    
    @IBAction func resetTimer(){
        timerState = false
        elapsedTimeInscond = 0
        updateTimeLabel()
        resetButton.isHidden = true
        startButton.setTitle("開始", for: .normal)
        timer?.invalidate()
    }

}

