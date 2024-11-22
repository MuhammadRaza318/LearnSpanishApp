//
//  ClassOneCollectionViewController.swift
//  LearnSpanish
//
//  Created by Zain on 11/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
import UnityAds
class ClassOneCollectionViewController: UIViewController , UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , GADFullScreenContentDelegate {

    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var quizView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var imageOne: UIButton!
    @IBOutlet weak var imageTwo: UIButton!
    @IBOutlet weak var imageThree: UIButton!
    @IBOutlet weak var imageFour: UIButton!
    var audio : AVAudioPlayer!
    var object = ArraysClass()
    @IBOutlet weak var collectionView: UICollectionView!
  
    var randomNumber = 0
    var randomNumber2 = 0
    var randomNumber3 = 0
    var randomNumber4 = 0
    
    var checkArray : [Int] = []
    var questionsIndexArray : [Int] = []
    var qCounter = 0
    
    static var globalClickCounter = 0
    var isFirstAdShown = false
    var interstitial: GADInterstitialAd!
    var flagForViewWillAppear: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flagForViewWillAppear = true
        initializeUnityAds()
        
        
        self.topLabel.text = SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
        self.topLabel.adjustsFontSizeToFitWidth = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        quizView.backgroundColor = UIColor.clear
        
        if(SecondViewController.staticVal.index == 0)
        {
            quizView.isHidden = true
            collectionView.isHidden = false
        }
        else if (SecondViewController.staticVal.index == 1)
        {
         self.collectionView.isHidden = true
            quizView.isHidden = false
            qCounter += 1
            counterLabel.text = String(qCounter) + " of " + String(object.alphabetsMp3.count)
             counterLabel.adjustsFontSizeToFitWidth = true
            questionIndex()
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
        return object.alphabets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassOneCollectionViewCell", for: indexPath) as! ClassOneCollectionViewCell
        cell.imageContent.image = UIImage(named: object.alphabets[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.collectionView.frame.size.width / 2
        var height = self.collectionView.frame.size.height / 3.5
        
        if ( UIDevice.current.userInterfaceIdiom == .pad )
        {
            width = self.collectionView.frame.size.width / 2
            height = self.collectionView.frame.size.height / 2.5
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: object.alphabetsMp3[indexPath.item], ofType: "mp3")!) as URL)
        audio.play()
        
        ClassOneCollectionViewController.globalClickCounter += 1

        // Show first ad only when the click count reaches 4
        if ClassOneCollectionViewController.globalClickCounter == 4 && !isFirstAdShown {
            showInterstitial() // Show Google Interstitial Ad first
            isFirstAdShown = true
        } else if isFirstAdShown && ClassOneCollectionViewController.globalClickCounter % 4 == 0 {
            // Alternate between Google Interstitial and Unity ads on every 4th click
            if ((ClassOneCollectionViewController.globalClickCounter / 4) % 2) == 0 {
                showInterstitial() // Show Google Interstitial Ad
            } else {
                unityAdsDisplay() // Show Unity Ad
            }
        }

    }
    
    /// Back to Previous View Controller
    
    @IBAction func back(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.navigationController?.pushViewController(viewController!, animated: false)
    }
    
    @IBAction func playSound(_ sender: Any) {
        if(audio != nil)
        {
            audio.play()
        }
        
    }
    
    
    func questionIndex()
    {
        nextBtn.isHidden = true
        let check  = Int(arc4random_uniform(UInt32(4)))
        
        
        
        randomNumber = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        
        while(questionsIndexArray.contains(randomNumber))
        {
            randomNumber = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        }
        questionsIndexArray.append(randomNumber)
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: object.alphabetsMp3[randomNumber], ofType: "mp3")!) as URL)
        randomNumber2 = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        randomNumber3 = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        randomNumber4 = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        
        checkArray.append(randomNumber)
        
        while(checkArray.contains(randomNumber2))
        {
            randomNumber2 = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        }
        checkArray.append(randomNumber2)
        
        while(checkArray.contains(randomNumber3))
        {
            randomNumber3 = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        }
        checkArray.append(randomNumber3)
        
        while(checkArray.contains(randomNumber4))
        {
            randomNumber4 = Int(arc4random_uniform(UInt32(object.alphabetsMp3.count)))
        }
        checkArray.append(randomNumber4)
        
        print(randomNumber , randomNumber2 , randomNumber3 , randomNumber4)
        
        if(check == 0)
        {
            imageOne.setImage(UIImage(named: object.alphabets[randomNumber]), for: .normal)
            imageOne.tag = randomNumber
            imageTwo.tag = randomNumber2
            imageThree.tag = randomNumber3
            imageFour.tag = randomNumber4
            imageTwo.setImage(UIImage(named: object.alphabets[randomNumber2]), for: .normal)
            imageThree.setImage(UIImage(named: object.alphabets[randomNumber3]), for: .normal)
            imageFour.setImage(UIImage(named: object.alphabets[randomNumber4]), for: .normal)
            
            
        }
        else if(check == 1)
        {
            imageOne.setImage(UIImage(named: object.alphabets[randomNumber2]), for: .normal)
            imageTwo.setImage(UIImage(named: object.alphabets[randomNumber]), for: .normal)
            imageThree.setImage(UIImage(named: object.alphabets[randomNumber3]), for: .normal)
            imageFour.setImage(UIImage(named: object.alphabets[randomNumber4]), for: .normal)
            imageOne.tag = randomNumber2
            imageTwo.tag = randomNumber
            imageThree.tag = randomNumber3
            imageFour.tag = randomNumber4
        }
        else if (check == 2)
        {
            imageOne.setImage(UIImage(named: object.alphabets[randomNumber3]), for: .normal)
            imageTwo.setImage(UIImage(named: object.alphabets[randomNumber2]), for: .normal)
            imageThree.setImage(UIImage(named: object.alphabets[randomNumber]), for: .normal)
            imageFour.setImage(UIImage(named: object.alphabets[randomNumber4]), for: .normal)
            imageOne.tag = randomNumber3
            imageTwo.tag = randomNumber2
            imageThree.tag = randomNumber
            imageFour.tag = randomNumber4
        }
        else if (check == 3)
        {
            imageOne.setImage(UIImage(named: object.alphabets[randomNumber4]), for: .normal)
            imageTwo.setImage(UIImage(named: object.alphabets[randomNumber2]), for: .normal)
            imageThree.setImage(UIImage(named: object.alphabets[randomNumber3]), for: .normal)
            imageFour.setImage(UIImage(named: object.alphabets[randomNumber]), for: .normal)
            imageOne.tag = randomNumber4
            imageTwo.tag = randomNumber2
            imageThree.tag = randomNumber3
            imageFour.tag = randomNumber
        }
        
        
        checkArray.removeAll()
    }
    
    
    @IBAction func imageOneAction(_ sender: Any) {
        if(imageOne.tag == randomNumber)
        {
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            nextBtn.isHidden = false
            
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
        
    }
    
    @IBAction func imageTwoAction(_ sender: Any) {
        if(imageTwo.tag == randomNumber)
        {
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            nextBtn.isHidden = false
            
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
        
    }
    @IBAction func imageThreeAction(_ sender: Any) {
        if(imageThree.tag == randomNumber)
        {
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            nextBtn.isHidden = false
            
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
    }
    
    @IBAction func imageFourAction(_ sender: Any) {
        if(imageFour.tag == randomNumber)
        {
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            nextBtn.isHidden = false
            
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
    }

    @IBAction func nextAction(_ sender: Any) {
        if(object.alphabetsMp3.count == questionsIndexArray.count)
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
            image.isHidden = true
            
            questionIndex()
            qCounter += 1
            counterLabel.text = String(qCounter) + " of " + String(object.alphabetsMp3.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            
            imageOne.isEnabled = true
            imageTwo.isEnabled = true
            imageThree.isEnabled = true
            imageFour.isEnabled = true
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if flagForViewWillAppear {
            if !UserDefaults.standard.bool(forKey: "isProUser") {
                createAndLoadInterstitial()
               
            } else {
                removeAds()
               
            }
        }
    }
    
    
    func removeAds(){
        
        createAndLoadInterstitial()
         
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
}




extension ClassOneCollectionViewController: UnityAdsInitializationDelegate {
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

extension ClassOneCollectionViewController: UnityAdsLoadDelegate, UnityAdsShowDelegate{
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

