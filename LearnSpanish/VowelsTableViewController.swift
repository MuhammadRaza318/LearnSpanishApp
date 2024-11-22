//
//  VowelsTableViewController.swift
//  LearnSpanish
//
//  Created by Zain on 13/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class VowelsTableViewController: UIViewController  , UITableViewDataSource , UITableViewDelegate , GADBannerViewDelegate {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var topLabel: UILabel!
    var timer = Timer()
    
    var englishArray : [String] = []

    var mp3Array : [String] = []
    var audio : AVAudioPlayer!
    var tagCounter = 0
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
       self.topLabel.text = SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
        self.topLabel.adjustsFontSizeToFitWidth = true
            getData(table: SecondViewController.staticVal.dbTable)
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func getData(table : String)
    {
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("learnSpanish.sqlite")
        let fullDestPathString = String(describing: fullDestPath)
        
        var db: OpaquePointer? = nil
        db = openDatabase()
        
        let queryStatementString = "SELECT * FROM " + SecondViewController.staticVal.dbTable + ";"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
        }
        else
        {
            
            print("SELECT statement could not be prepared")
        }
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            
            
            let queryResultCol2 = sqlite3_column_text(queryStatement, 1)
            let mp3Name  = String.init(cString: queryResultCol2!)
            // print(spanishName)
            let queryResultCol3 = sqlite3_column_text(queryStatement, 0)
            let engName = String.init(cString: queryResultCol3!)
            //print(engName)
            englishArray.append(engName)
            
            mp3Array.append(mp3Name)
        }
        //        print(englishArray)
        //        print(spanishArray)
        //        print(mp3Array)
   
        
        sqlite3_finalize(queryStatement)
        
    }
    
    func openDatabase() -> OpaquePointer {
        let part1DbPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("learnSpanish.sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(part1DbPath.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(part1DbPath)")
            return db!
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            // XCPlaygroundPage.currentPage.finishExecution()
        }
        return db!
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return englishArray.count
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VowelsTableViewCell", for: indexPath) as!  VowelsTableViewCell
        cell.label.text = englishArray[indexPath.row]
            cell.label.adjustsFontSizeToFitWidth = true
            cell.playBtn.tag = indexPath.row
        cell.backgroundColor = UIColor.clear
            return cell
 
    }

    @IBAction func playAction(_ sender: Any) {
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[(sender as AnyObject).tag], ofType: "mp3")!) as URL)
        audio.play()
      //  presentInterstitial()
    }
  
    @IBAction func back(_ sender: Any) {
        timer.invalidate()
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.navigationController?.pushViewController(viewController!, animated: false)

    }
}
