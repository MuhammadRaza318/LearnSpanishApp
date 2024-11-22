//
//  MainCollectionViewController.swift
//  LearnSpanish
//
//  Created by Zain on 11/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AdSupport
import AppTrackingTransparency
import UnityAds
@available(iOS 14, *)
class MainCollectionViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout , GADBannerViewDelegate  , GADFullScreenContentDelegate {
    let viewModel = TrackingViewModel()
    static var idfa: UUID {
        return ASIdentifierManager.shared().advertisingIdentifier
    }
    static var globalClickCounter = 0
    var isFirstAdShown = false
    var interstitial: GADInterstitialAd!
    var flagForViewWillAppear: Bool = false
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
   
    
    
    var timer = Timer()
    static var adsCount = 1
    struct staticVal
    {
        static var dbTable = ""
        static var mainIndex = 0
        static var timer = interstitialTimer
        static var labelsArray : [String] = ["Basics" , "Greetings" , "Polite Expressions" , "Praise" , "Days,Months,Seasons" , "Climate" , "Time" , "Common Questions", "Directions" , "Instructions" , "Health and Safety","Shifts and Pay" , "Around the Office" , "Animals" , "Tools and Equipments" , "Measurement" , "People" , "Crops and Plants" , "Holidays - Sympathies" , "Irrigation" , "Food and Drinks" , "Love" , "Physical Appearance","Conversation Stater" , "Internet Terms" , "House"]
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var mainArray : [String] = ["mainButton1.png","mainButton2.png","mainButton3.png","mainButton4.png","mainButton5.png","mainButton6.png","mainButton7.png","mainButton8.png","mainButton9.png","mainButton10.png","mainButton11.png","mainButton12.png","mainButton13.png","mainButton14.png","mainButton15.png","mainButton16.png","mainButton17.png","mainButton18.png","mainButton19.png","mainButton20.png","mainButton21.png","mainButton22.png","mainButton23.png","mainButton24.png","mainButton25.png","mainButton26.png"]
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        dataBaseConnection()
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
        topLabel.adjustsFontSizeToFitWidth = true
        viewModel.requestPermission()
        
        flagForViewWillAppear = true
        checkAndShowPurchaseViewController()
        initializeUnityAds()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    // Collection View Delegates
    func initializeUnityAds() {
        if !UserDefaults.standard.bool(forKey: "isProUser") {
                   UnityAds.initialize(UNITYID, testMode: false)
            loadUnityVieoAd()
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

  
    // Method to present PurchaseViewController
        func presentPurchaseViewController() {
            guard let purchaseViewController = storyboard?.instantiateViewController(withIdentifier: "PurchaseViewController") as? PurchaseViewController else {
                return
            }
            purchaseViewController.modalPresentationStyle = .fullScreen
            present(purchaseViewController, animated: true, completion: nil)
        }

        func checkAndShowPurchaseViewController() {
            let defaults = UserDefaults.standard
            let hasShownPurchaseViewController = defaults.bool(forKey: "HasShownPurchaseViewController")
            
            if !hasShownPurchaseViewController {
                // Show the PurchaseViewController
                presentPurchaseViewController()
                
                // Set the flag to true so it won't show again
                defaults.set(true, forKey: "HasShownPurchaseViewController")
                defaults.synchronize()
            }
        }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.imageContent.image = UIImage(named: mainArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.collectionView.frame.size.width
        var height = self.collectionView.frame.size.height / 8
        if ( UIDevice.current.userInterfaceIdiom == .pad )
        {
            width = self.collectionView.frame.size.width
            height = self.collectionView.frame.size.height / 6
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SecondViewController.staticVal.backFlagCheck = false
              timer.invalidate()
                
              let transition = CATransition()
              transition.duration = 0.4
              transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
              transition.type = kCATransitionPush
              transition.subtype = kCATransitionFromRight
              self.view.window!.layer.add(transition, forKey: nil)
                
              // Array or dictionary to store dbTable names
              let dbTableNames = [
                  1: "greetings", 2: "politeExpression", 3: "praise", 4: "dms", 5: "climate",
                  6: "time", 7: "cquestions", 8: "directions", 9: "instructions", 10: "healthS",
                  11: "shiftpay", 12: "aroundoffice", 13: "animals", 14: "toolsEq", 15: "measurement",
                  16: "people", 17: "cp", 18: "holidays", 19: "irrigation", 20: "food",
                  21: "love", 22: "physicalapp", 23: "cstater", 24: "internetterms", 25: "house"
              ]
              
              MainCollectionViewController.staticVal.mainIndex = indexPath.item
              if indexPath.item == 0 {
                  let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
                  self.navigationController?.pushViewController(viewController!, animated: false)
              } else if let dbTable = dbTableNames[indexPath.item] {
                  MainCollectionViewController.staticVal.dbTable = dbTable
                  let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondMenuCollectionViewController")
                  self.navigationController?.pushViewController(viewController!, animated: false)
              }
             
              MainCollectionViewController.globalClickCounter += 1
              
              if MainCollectionViewController.globalClickCounter == 1 && !isFirstAdShown {
                  showInterstitial()
                  isFirstAdShown = true
              } else if MainCollectionViewController.globalClickCounter % 4 == 0 {
                  if (MainCollectionViewController.globalClickCounter / 4) % 2 == 0 {
                      showInterstitial()
                  } else {
                      unityAdsDisplay()
            }
        }
    }
    func dataBaseConnection()
    {
        let bundlePath = Bundle.main.path(forResource: "learnSpanish", ofType: ".sqlite")
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = URL(fileURLWithPath: destPath).appendingPathComponent("learnSpanish.sqlite")
        if fileManager.fileExists(atPath: fullDestPath.path){
            print("Database file is exist")
            print(fileManager.fileExists(atPath: bundlePath!))
            print(fullDestPath.path)
        }else{
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPath.path)
            }catch{
                print("\n",error)
            }
        }
    }
    
   
    
    @IBAction func purchaseBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let purchaseVC = storyboard.instantiateViewController(withIdentifier: "PurchaseViewController") as? PurchaseViewController {
                // Present the PurchaseViewController modally
                purchaseVC.modalPresentationStyle = .fullScreen
                present(purchaseVC, animated: true, completion: nil)
            } else {
                print("Failed to instantiate PurchaseViewController.")
            }
    }
    
    
    
}


extension MainCollectionViewController: UnityAdsInitializationDelegate {
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

extension MainCollectionViewController: UnityAdsLoadDelegate, UnityAdsShowDelegate{
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

