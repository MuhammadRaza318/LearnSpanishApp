//
//  SecondViewController.swift
//  LearnSpanish
//
//  Created by Zain on 11/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import GoogleMobileAds
import UnityAds
class SecondViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , GADBannerViewDelegate , GADFullScreenContentDelegate {
    var timer = Timer()
    @IBOutlet weak var topView: UIView!
    static var globalClickCounter = 0
    var isFirstAdShown = false
    var interstitial: GADInterstitialAd!
    var flagForViewWillAppear: Bool = false
    
    struct staticVal
    {
        static var index = 0
        static var dbTable = ""
        static var posFlag = false
        static var backFlagCheck = false
        static var basicArray :[String] = ["Alphabets" , "Alphabet Quiz" , "Numbers" , "Number Theory" , "Numbers Quiz" , "Vowels Pronounciation" , "Vowels Thoery" , "Body Parts" , "Fruits and Vegitables" , "Parts of Speech" , "Clothes" , "Clothes Quiz" , "Colors" , "Colors Quiz" , "Family Members" , "Family Members Quiz" , "100 Common Words" , "100 Common Words Quiz" , "Personality" , "Personality Quiz" , "Profession" , "Profession Quiz" , "Shops and Places" , "Shops and Places Quiz" , " Vocabulary Set 1" ,"Vocabulary Set 2", "Vocabulary Set 3" , "Set 1 Quiz" , "Set 2 Quiz" , "Set 3 Quiz"]
    }

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var classOneArray : [String] = ["subMenu-sp-alpha.png","subMenu-sp-alphaQ.png","subMenu-sp-numbers.png" , "subMenu-sp-numbers-Theory.png","subMenu-sp-numbers-Q.png","subMenu-sp-vowelsP.png","subMenu-sp-vowelsT.png","submenubodyparts.png","submenufruitsveg.png","submenupartsofspeech.png","clothes.png","clothesquiz.png","colors.png","colorsquiz.png","family.png","familyquiz.png","huncommon.png","huncommonquiz.png","personality.png","personalityquiz.png","profession.png","professionquiz.png","publicplaces.png","publicplacesquiz.png","vacab1.png","vacab2.png","vacab3.png","vacabtest1.png","vacabtest2.png","vacabtest3.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        self.topLabel.text = MainCollectionViewController.staticVal.labelsArray[MainCollectionViewController.staticVal.mainIndex]
        self.topLabel.adjustsFontSizeToFitWidth = true
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        timer = Timer()
        
        SecondViewController.staticVal.posFlag = false
        
        flagForViewWillAppear = true
        initializeUnityAds()
    }
    // CollectionView Delegates
    
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
        return classOneArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
        cell.imageContent.image = UIImage(named: classOneArray[indexPath.row])
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
        timer.invalidate()
        SecondViewController.staticVal.index = indexPath.item
        if(indexPath.item == 0)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClassOneCollectionViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 1)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClassOneCollectionViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 2)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "Numbers"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 3)
        {
            
            //alert
            let alertController = UIAlertController(title: "Numbers", message: "Spanish numbers belong to an indo-Arabic based decimal system,although the history of the number system is much more ancient.The spanish numbers are not difficult to Learn", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: true, completion:nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 4)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "Numbers"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 5)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "Vowels"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "VowelsTableViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 6)
        {
            //alert //K4upZ6cNqx
            let alertController = UIAlertController(title: "Vowels", message: "There are 5 Vowels in Spanish A,E,I,O,U. Vowels in Spanish are pronounced differently from their English equivalents. The vowels a,e and o are pronounced quite softly,while i and u are pronounced with strong tone", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: true, completion:nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 7)
        {
            MainCollectionViewController.staticVal.dbTable = "bodyparts"
            SecondViewController.staticVal.backFlagCheck = true
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondMenuCollectionViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 8)
        {
            MainCollectionViewController.staticVal.dbTable = "fruitsveg"
            SecondViewController.staticVal.backFlagCheck = true
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondMenuCollectionViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 9)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PartsOfSpeechViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 10)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //clothes
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "clothes"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
            
        }
        else if (indexPath.item == 11)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //clothes Quiz
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "clothes"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 12)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //colurs
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "colors"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 13)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "colors"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 14)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //family
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "family"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 15)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "family"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 16)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //100words
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "Words"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 17)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "Words"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 18)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //personality
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "personality"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 19)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "personality"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 20)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //profession
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "profession"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 21)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "profession"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 22)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //Shop $ places
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "places"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 23)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "places"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 24)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //v1
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "vocab1"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 25)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //v2
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "vocab2"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 26)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //v3
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "vocab3"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }else if (indexPath.item == 27)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //vq1
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "vocab1"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 28)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //vq2
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "vocab2"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 29)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            //vq3
            SecondViewController.staticVal.index = indexPath.item
            SecondViewController.staticVal.dbTable = "vocab3"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        
        
        SecondViewController.globalClickCounter += 1
        
        if SecondViewController.globalClickCounter == 1 && !isFirstAdShown {
            showInterstitial()
            isFirstAdShown = true
        } else if SecondViewController.globalClickCounter % 4 == 0 {
            if (SecondViewController.globalClickCounter / 4) % 2 == 0 {
                showInterstitial()
            } else {
                unityAdsDisplay()
      }
  }
        
}

    // Move to Last Controller
    
    @IBAction func back(_ sender: Any) {
        timer.invalidate()
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCollectionViewController")
        self.navigationController?.pushViewController(viewController!, animated: false)
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




extension SecondViewController: UnityAdsInitializationDelegate {
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

extension SecondViewController: UnityAdsLoadDelegate, UnityAdsShowDelegate{
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

