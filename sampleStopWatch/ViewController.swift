//
//  ViewController.swift
//  sampleStopWatch
//
//  Created by Yuji Yamamoto on 2017/08/05.
//  Copyright © 2017年 Yuji Yamamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var laps = [""]
//    var startWatch = true //初めの状態、つまり止まっている状態がTrue
    var countNmb = 0
    var timerRunning = false
    var addLap = true
    var timer = Timer()
    
    func timeFormat(){
        let ms = countNmb % 100
        let s = (countNmb - ms) / 100 % 60
        let m = (countNmb - ms - s) / 6000 % 3600
        stopWatchLabel.text = String(format: "%02d:%02d.%02d", m,s,ms)
    }
    
    //timerの表示画面
    @IBOutlet weak var stopWatchLabel: UILabel!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var starStopBtn: UIButton!

    @IBOutlet weak var resetBtn: UIButton!
    
    @IBOutlet weak var lapBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopWatchLabel.text = "00:00.00"
        
    }
    
    //StarBtnを押すと、stopwatchがstartとstopを繰り返す
    @IBAction func startStopBtn(_ sender: UIButton) {
        if timerRunning == true{ //初期値はtimerunning == falseなのでpressされた時がこの場合trueとなる
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: Selector("updateStopWatch"), userInfo: nil, repeats: true)
            timerRunning = false
            addLap = true
        }else{
           timer.invalidate()
            timerRunning = true
            addLap = false
        }
    }
    
    //ResetBtn
    @IBAction func resetBtn(_ sender: UIButton) {
        countNmb = 0
        stopWatchLabel.text = "00:00.00"
    }
    
    
    
    func updateStopWatch(){
            countNmb += 1
            timeFormat()
    }


//lapが表示されるtableviewの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        
//        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap\(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    @IBAction func lapBtn(_ sender: UIButton) {
        if addLap == true{
            laps.insert(stopWatchLabel.text!, at: 0)
            lapsTableView.reloadData()
            
        }else{
            addLap = false
        }
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }

}







