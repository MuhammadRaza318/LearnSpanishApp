//
//  SecondMenuCollectionViewController.swift
//  LearnSpanish
//
//  Created by Zain on 16/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import GoogleMobileAds
import UnityAds
class SecondMenuCollectionViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , GADBannerViewDelegate , GADFullScreenContentDelegate{
    static var globalClickCounter = 0
    var isFirstAdShown = false
    var interstitial: GADInterstitialAd!
    var flagForViewWillAppear: Bool = false
    
    @IBOutlet weak var topView: UIView!
    struct staticVal
    {
        static var checkFlag = false
    }
    
    var timer  = Timer()
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var topLabel: UILabel!
    var object = ArraysClass()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
       
        flagForViewWillAppear = true
        initializeUnityAds()
        
        if(SecondViewController.staticVal.backFlagCheck == true)
        {
            self.topLabel.text = SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
            self.topLabel.adjustsFontSizeToFitWidth = true
        }
        else
        {
            self.topLabel.text = MainCollectionViewController.staticVal.labelsArray[MainCollectionViewController.staticVal.mainIndex]
            self.topLabel.adjustsFontForContentSizeCategory = true
        }
       
    }

    func initializeUnityAds() {
        if !UserDefaults.standard.bool(forKey: "isProUser") {
                   UnityAds.initialize(UNITYID, testMode: false)
            loadUnityVieoAd()
               }
        }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  object.subMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondMenuCollectionViewCell", for: indexPath) as! SecondMenuCollectionViewCell
        cell.imageContent.image = UIImage(named: object.subMenu[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.collectionView.frame.size.width
        var height = self.collectionView.frame.size.height / 8
        if ( UIDevice.current.userInterfaceIdiom == .pad )
        {
            width = self.collectionView.frame.size.width
            height = self.collectionView.frame.size.height / 6.5
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        timer.invalidate()
     //  presentInterstitial()
        if(indexPath.item == 0)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondLearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)

        }
        else if(indexPath.item == 1)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SlideShowViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if(indexPath.item == 2)
        {
            SecondMenuCollectionViewController.staticVal.checkFlag = false
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ListningQuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if(indexPath.item == 3)
        {
            SecondMenuCollectionViewController.staticVal.checkFlag = true
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ListningQuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if(indexPath.item == 4)
        {
            SecondMenuCollectionViewController.staticVal.checkFlag = false
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondQuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if(indexPath.item == 5)
        {
            SecondMenuCollectionViewController.staticVal.checkFlag = true
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondQuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        
        
        SecondMenuCollectionViewController.globalClickCounter += 1
        
        if SecondMenuCollectionViewController.globalClickCounter == 1 && !isFirstAdShown {
            showInterstitial()
            isFirstAdShown = true
        } else if SecondMenuCollectionViewController.globalClickCounter % 4 == 0 {
            if (SecondMenuCollectionViewController.globalClickCounter / 4) % 2 == 0 {
                showInterstitial()
            } else {
                unityAdsDisplay()
      }
  }
        
}

    @IBAction func back(_ sender: Any) {
        timer.invalidate()
        if(SecondViewController.staticVal.backFlagCheck == true)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            self.view.window!.layer.add(transition, forKey: nil)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            self.view.window!.layer.add(transition, forKey: nil)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCollectionViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
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





extension SecondMenuCollectionViewController: UnityAdsInitializationDelegate {
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

extension SecondMenuCollectionViewController: UnityAdsLoadDelegate, UnityAdsShowDelegate{
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

