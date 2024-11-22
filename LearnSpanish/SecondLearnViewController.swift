//
//  SecondLearnViewController.swift
//  LearnSpanish
//
//  Created by Zain on 16/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class SecondLearnViewController: UIViewController  , GADBannerViewDelegate{
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    var englishArray : [String] = []
    var spanishArray : [String] = []
    var mp3Array : [String] = []
    var mp3Array2 : [String] = []
    var counter = 0
    var audio : AVAudioPlayer!
    var audio2 : AVAudioPlayer!
    var timer = Timer()
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var spanishLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        if(SecondViewController.staticVal.backFlagCheck == true)
        {
            self.topLabel.text = "StudyList-" + SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
            self.topLabel.adjustsFontSizeToFitWidth = true
        }
        else
        {
            self.topLabel.text = "StudyList-" + MainCollectionViewController.staticVal.labelsArray[MainCollectionViewController.staticVal.mainIndex]
            self.topLabel.adjustsFontSizeToFitWidth = true
        }
        getData(table: MainCollectionViewController.staticVal.dbTable)
    }
    func getData(table : String)
    {
        
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("learnSpanish.sqlite")
        let fullDestPathString = String(describing: fullDestPath)
        
        var db: OpaquePointer? = nil
        db = openDatabase()
        
        let queryStatementString = "SELECT * FROM " + MainCollectionViewController.staticVal.dbTable + ";"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
        }
        else
        {
            
            print("SELECT statement could not be prepared")
        }
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            
            let queryResultCol = sqlite3_column_text(queryStatement, 2)
            let mp3Name  = String.init(cString: queryResultCol!)
            // print(mp3Name)
            let queryResultCol2 = sqlite3_column_text(queryStatement, 1)
            let spanishName  = String.init(cString: queryResultCol2!)
            // print(spanishName)
            let queryResultCol3 = sqlite3_column_text(queryStatement, 0)
            let engName = String.init(cString: queryResultCol3!)
            
            let queryResultCol4 = sqlite3_column_text(queryStatement, 3)
            var mp3Name2  = String.init(cString: queryResultCol4!)
            //print(engName)
            englishArray.append(engName)
            spanishArray.append(spanishName)
            mp3Array.append(mp3Name)
            mp3Array2.append(mp3Name2)
        }
        //        print(englishArray)
        //        print(spanishArray)
        //        print(mp3Array)
        englishLabel.text = englishArray[counter]
        englishLabel.adjustsFontSizeToFitWidth = true
        spanishLabel.text = spanishArray[counter]
        spanishLabel.adjustsFontSizeToFitWidth = true
        audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
        counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
        counterLabel.adjustsFontSizeToFitWidth = true
        
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
    @IBAction func playOne(_ sender: Any) {
        if(audio != nil )
        {
            if(!audio.isPlaying)
            {
                audio.play()
            }
        }
    //    presentInterstitial()
    }
    

    @IBAction func playTwo(_ sender: Any) {
        //sp
        if(audio2 != nil )
        {
            if(!audio2.isPlaying)
            {
                audio2.play()
            }
        }
     //   presentInterstitial()
    }

    @IBAction func nextAction(_ sender: Any) {
        if(counter == englishArray.count - 1)
        {
            counter = 0
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            counter += 1
            
        }
        else
        {
            counter += 1
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            
        }
      //  presentInterstitial()
    }
    @IBAction func previousAction(_ sender: Any) {
        if(counter == 0)
        {
            counter = englishArray.count - 1
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            counter -= 1
            
        }
        else
        {
            counter -= 1
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            
        }
       // presentInterstitial()

    }
    @IBAction func back(_ sender: Any) {
        timer.invalidate()
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondMenuCollectionViewController")
        self.navigationController?.pushViewController(viewController!, animated: false)
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.bannerView.isHidden = false
        
       
        
        self.bannerView.frame = CGRect(x: 0, y:  self.view.frame.size.height - self.bannerView.frame.size.height, width: self.bannerView.frame.size.width, height: self.bannerView.frame.size.height)
        
    }
}
