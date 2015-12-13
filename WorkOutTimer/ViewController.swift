//
//  ViewController.swift
//  WorkOutTimer
//
//  Created by MIchelle Grover on 12/12/15.
//  Copyright © 2015 Norbert Grover. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var timer = NSTimer()
    var minutes:Int = 0
    var seconds:Int = 0
    var fraction:Int = 0
    var stopWatchString:String = ""
    var laps:[String] = []
    
    var startStopWatch:Bool = true
    var addLap:Bool = false
    
    
    @IBOutlet weak var lblStartStop: UIButton!
    @IBOutlet weak var lblLapReset: UIButton!
    @IBOutlet weak var lblStopWatchDisplay: UILabel!
    @IBOutlet weak var tblviewLaps: UITableView!
    
    @IBAction func startStopAction(sender: AnyObject) {
        if (startStopWatch == true) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateStopWatch"), userInfo: nil, repeats: true)
            startStopWatch = false
            self.lblStartStop.setTitle("Stop", forState: UIControlState.Normal)
            self.lblLapReset.setTitle("Lap", forState: UIControlState.Normal)
            addLap = true
        } else {
            timer.invalidate()
            startStopWatch = true
            lblStartStop.setTitle("Start", forState: UIControlState.Normal)
            lblLapReset.setTitle("Reset", forState: UIControlState.Normal)
            addLap = false        
        }
    }
    @IBAction func lapResetAction(sender: AnyObject) {
        if (addLap == true) {
            laps.insert(stopWatchString, atIndex: 0)
            tblviewLaps.reloadData()
        } else {
            addLap = false
            laps.removeAll(keepCapacity: false)
            tblviewLaps.reloadData()
            self.lblLapReset.setTitle("Reset", forState: UIControlState.Normal)
            fraction = 0
            minutes = 0
            seconds = 0
            stopWatchString = "00:00:00"
            self.lblStopWatchDisplay.text = stopWatchString
        }
    }
    
    func updateStopWatch() {
        fraction += 1
        
        if (fraction == 100) {
            seconds += 1
            fraction = 0
        }
        if (seconds == 60) {
            minutes += 1
            seconds = 0
        }
        
        let fractionString = fraction > 9 ? "\(fraction)" : "0\(fraction)"
        let secondString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        stopWatchString = "\(minutesString):\(secondString):\(fractionString)"
        self.lblStopWatchDisplay.text = stopWatchString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblStartStop.layer.borderWidth = 3
        self.lblStartStop.layer.borderColor = UIColor.blackColor().CGColor
        self.lblStartStop.layer.cornerRadius = self.lblStartStop.frame.size.width / 2
       self.lblLapReset.layer.borderWidth = 3
        self.lblLapReset.layer.borderColor = UIColor.blackColor().CGColor
        self.lblLapReset.layer.cornerRadius = self.lblLapReset.frame.size.width / 2
        
        self.lblStopWatchDisplay.text = "00:00:00"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel!.text = laps[indexPath.row]
        return cell
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }

}

