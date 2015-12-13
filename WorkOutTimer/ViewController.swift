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
    let minutes:Int = 0
    let seconds:Int = 0
    let fraction:Int = 0
    
    var startStopWatch:Bool = true
    var addLap:Bool = false
    
    
    @IBOutlet weak var lblStartStop: UIButton!
    @IBOutlet weak var lblLapReset: UIButton!
    @IBOutlet weak var lblStopWatchDisplay: UILabel!
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblStartStop.layer.borderWidth = 3
        self.lblStartStop.layer.borderColor = UIColor.blackColor().CGColor
        self.lblStartStop.layer.cornerRadius = self.lblStartStop.frame.size.width / 2
       self.lblLapReset.layer.borderWidth = 3
        self.lblLapReset.layer.borderColor = UIColor.blackColor().CGColor
        self.lblLapReset.layer.cornerRadius = self.lblLapReset.frame.size.width / 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap"
        cell.detailTextLabel!.text = "00:00:00"
        return cell
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}

