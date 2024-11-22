//
//  SlideShowViewController.swift
//  LearnSpanish
//
//  Created by Zain on 16/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
import UnityAds
class SlideShowViewController: UIViewController  , AVAudioPlayerDelegate ,GADBannerViewDelegate ,GADFullScreenContentDelegate {
    
    static var globalClickCounter = 0
    var isFirstAdShown = false
    var interstitial: GADInterstitialAd!
    var flagForViewWillAppear: Bool = false
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    var englishArray : [String] = []
    var spanishArray : [String] = []
    var mp3Array : [String] = []
    var mp3Array2 : [String] = []
    var counter = 0
    var audioCounter = 0
    var audioFlag = false
    var audio : AVAudioPlayer!
    var audio2 : AVAudioPlayer!
    var timer = Timer()
    var pauseFlag = 0
    var pause = false
    
    @IBOutlet weak var spanishLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!

    
    override func viewDidDisappear(_ animated: Bool) {
   
        if(audio.isPlaying)
        {
            audio.pause()
            playBtn.setImage(UIImage(named: "slideshow-play.png"), for: .normal)
            pauseFlag = 1
        }
        else if (audio2.isPlaying)
        {
            audio2.pause()
            playBtn.setImage(UIImage(named: "slideshow-play.png"), for: .normal)
            pauseFlag = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagForViewWillAppear = true
        initializeUnityAds()
        
        if(SecondViewController.staticVal.backFlagCheck == true)
        {
            self.topLabel.text = "SlideShow-" + SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
            self.topLabel.adjustsFontSizeToFitWidth = true
        }
        else
        {
            self.topLabel.text = "SlideShow-" + MainCollectionViewController.staticVal.labelsArray[MainCollectionViewController.staticVal.mainIndex]
            self.topLabel.adjustsFontSizeToFitWidth = true
        }
        getData(table: MainCollectionViewController.staticVal.dbTable)
        audio.delegate = self
        audio2.delegate = self
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
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
        englishLabel.text = englishArray[counter]
        englishLabel.adjustsFontSizeToFitWidth = true
        spanishLabel.text = spanishArray[counter]
        spanishLabel.adjustsFontSizeToFitWidth = true
        audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
        counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
        counterLabel.adjustsFontSizeToFitWidth = true
        audio.play()
        
        sqlite3_finalize(queryStatement)
        
    }
    
    func initializeUnityAds() {
        if !UserDefaults.standard.bool(forKey: "isProUser") {
                   UnityAds.initialize(UNITYID, testMode: false)
            loadUnityVieoAd()
               }
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
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if(audioCounter < 3)
        {
            
            if(audioFlag == false)
            {
                audio2.play()
                playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
                audio.delegate = self
                audio2.delegate = self
                audioCounter += 1
                audioFlag = true
            }
            else
            {
                audio.play()
                playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
                audio.delegate = self
                audio2.delegate = self
                audioFlag = false
            }
            
        }
        else
        {
            audioCounter = 0
            counter += 1
            if(counter == (englishArray.count))
            {
                counter = 0
            }
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            audio.play()
            playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            audio.delegate = self
            audio2.delegate = self
            audioFlag = false
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        if(counter == englishArray.count - 1)
        {
            audio2.stop()
            audio.stop()
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
            audio.play()
            playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            audioCounter = 0
            audio.delegate = self
            audio2.delegate = self
            audioFlag = false
            
        }
        else
        {
            audio2.stop()
            audio.stop()
            counter += 1
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            audio.play()
            playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            audioCounter = 0
            audio.delegate = self
            audio2.delegate = self
            audioFlag = false
            
        }
       // presentInterstitial()
        showAdsUnityandGoogel()
    }

    
    
    @IBAction func previousAction(_ sender: Any) {
       
        if(counter == 0)
        {
            audio2.stop()
            audio.stop()
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
            audio.play()
            playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            audioCounter = 0
            audio.delegate = self
            audio2.delegate = self
            audioFlag = false
            
        }
        else
        {
            audio2.stop()
            audio.stop()
            counter -= 1
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            audio.play()
            playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            audioCounter = 0
            audio.delegate = self
            audio2.delegate = self
            audioFlag = false
            
        }
        showAdsUnityandGoogel()
     //   presentInterstitial()
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
        
        showAdsUnityandGoogel()
    }
    
    func showAdsUnityandGoogel() {
        SlideShowViewController.globalClickCounter += 1

        // Show first ad only when the click count reaches 4
        if SlideShowViewController.globalClickCounter == 4 && !isFirstAdShown {
            showInterstitial() // Show Google Interstitial Ad first
            isFirstAdShown = true
        } else if isFirstAdShown && SlideShowViewController.globalClickCounter % 4 == 0 {
            // Alternate between Google Interstitial and Unity ads on every 4th click
            if ((SlideShowViewController.globalClickCounter / 4) % 2) == 0 {
                showInterstitial() // Show Google Interstitial Ad
            } else {
                unityAdsDisplay() // Show Unity Ad
            }
        }

    }
    @IBAction func playAction(_ sender: Any) {
        if(pause == false)
        {
            if(audio.isPlaying)
            {
                audio.pause()
                playBtn.setImage(UIImage(named: "slideshow-play.png"), for: .normal)
                pauseFlag = 1
            }
            else if (audio2.isPlaying)
            {
                audio2.pause()
                playBtn.setImage(UIImage(named: "slideshow-play.png"), for: .normal)
                pauseFlag = 2
            }
            else if(pauseFlag == 1)
            {
                audio.play()
                playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            }
            else if (pauseFlag == 2)
            {
                audio2.play()
                playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            }
        }
        else
        {
            englishLabel.text = englishArray[counter]
            englishLabel.adjustsFontSizeToFitWidth = true
            spanishLabel.text = spanishArray[counter]
            spanishLabel.adjustsFontSizeToFitWidth = true
            audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[counter], ofType: "mp3")!) as URL)
            audio2 = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array2[counter], ofType: "mp3")!) as URL)
            counterLabel.text = String(counter + 1) + " of " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            audio.play()
            playBtn.setImage(UIImage(named: "slideshow-pause.png"), for: .normal)
            audioCounter = 0
            audio.delegate = self
            audio2.delegate = self
            audioFlag = false

            pause = false
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if flagForViewWillAppear {
            if !UserDefaults.standard.bool(forKey: "isProUser") {
                createAndLoadInterstitial()
                self.bannerViewSetting()
                initializeUnityAds()
                      Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(loadBanner), userInfo: nil, repeats: true)
            } else {
                removeAds()
               
            }
        }
    }
    
    
    func removeAds(){
        
        createAndLoadInterstitial()
         bannerView.rootViewController = self
         bannerView.load(GADRequest())
        self.bannerView.isHidden = true
        bannerView.willRemoveSubview(bannerView)
    }
    
    
    func unityAdsDisplay() {
        if !UserDefaults.standard.bool(forKey: "isProUser") {
                    ShowVideoAd()
                } else {
                   
                }
    }
    
    func createAndLoadInterstitial(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: INTER_ID, request: request, completionHandler: { [self] ad, error in
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                print("Interstitial ad loaded successfully")
                interstitial = ad
                interstitial.fullScreenContentDelegate = self
            })
       }
       
       func showInterstitial() {
           if !UserDefaults.standard.bool(forKey: "isProUser") {
               if let interstitial = interstitial {
                   interstitial.present(fromRootViewController: self)
               } else {
                   print("Interstitial ad wasn't ready")
               }
           }
       }
       
       func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
           print("Ad did fail to present full screen content with error: \(error.localizedDescription)")
       }
       
       func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
           createAndLoadInterstitial()
       }
       
    
    // Banner Ads
    func bannerViewSetting() {
        
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
    }

    @objc func loadBanner(){
        
        bannerView.load(GADRequest())
    }
 
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        self.bannerView.frame.origin.y = (self.view.frame.size.height-self.bannerView.frame.size.height)
        print("adViewDidReceiveAd")
    }
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    
    
}


extension SlideShowViewController: UnityAdsInitializationDelegate {
    func loadUnityVieoAd() {
        UnityAds.load("video")
    }

    func ShowVideoAd() {
        if !UserDefaults.standard.bool(forKey: "isProUser") {
            UnityAds.show(self, placementId: "video", showDelegate: self)
        }
    }

    func initializationComplete() {
        print("Unity Ads Initialised")
    }
    
    func initializationFailed(_ error: UnityAdsInitializationError, withMessage message: String) {
        print("initializationFailed: ",message)
    }
    
    func unityAdsReady(_ placementId: String) {
        print(placementId)
    }
    
    func unityAdsDidStart(_ placementId: String) {
        
    }
    

}

extension SlideShowViewController: UnityAdsLoadDelegate, UnityAdsShowDelegate{
    func unityAdsShowComplete(_ placementId: String, withFinish state: UnityAdsShowCompletionState) {
        loadUnityVieoAd()
    }
    
    func unityAdsShowFailed(_ placementId: String, withError error: UnityAdsShowError, withMessage message: String) {
        loadUnityVieoAd()
    }
    
    func unityAdsShowStart(_ placementId: String) {
    }
    
    func unityAdsShowClick(_ placementId: String) {
        
    }
    
    
    func unityAdsAdLoaded(_ placementId: String) {
        print(placementId)
        loadUnityVieoAd()
    }
    
    func unityAdsAdFailed(toLoad placementId: String, withError error: UnityAdsLoadError, withMessage message: String) {
        print("unityAdsAdFailed: ", message)
    }
}

