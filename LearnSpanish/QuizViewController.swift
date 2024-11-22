//
//  QuizViewController.swift
//  LearnSpanish
//
//  Created by Zain on 12/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
class QuizViewController: UIViewController , GADBannerViewDelegate {
    var randomNumber = 0
    var randomNumber2 = 0
    var randomNumber3 = 0
    var randomNumber4 = 0
    @IBOutlet weak var imageOne: UIButton!
    @IBOutlet weak var imageTwo: UIButton!
    @IBOutlet weak var imageThree: UIButton!
    @IBOutlet weak var imageFour: UIButton!
    var timer = Timer()
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var bannerView: GADBannerView!
    var counter = 0
    var audio : AVAudioPlayer!
    var englishArray : [String] = []
    var spanishArray : [String] = []
    var mp3Array : [String] = []
    var checkArray : [Int] = []
    var questionsIndexArray : [Int] = []
    var qCounter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.isHidden = true
        image.isHidden = true
        self.topLabel.text = "Quiz-" + SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
        self.topLabel.adjustsFontSizeToFitWidth = true
        getData(table: SecondViewController.staticVal.dbTable)
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }


    
    // database Connection
    
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
            
            let queryResultCol = sqlite3_column_text(queryStatement, 2)
            let mp3Name  = String.init(cString: queryResultCol!)
            // print(mp3Name)
            let queryResultCol2 = sqlite3_column_text(queryStatement, 1)
            let spanishName  = String.init(cString: queryResultCol2!)
            // print(spanishName)
            let queryResultCol3 = sqlite3_column_text(queryStatement, 0)
            let engName = String.init(cString: queryResultCol3!)
            //print(engName)
            englishArray.append(engName)
            spanishArray.append(spanishName)
            mp3Array.append(mp3Name)
            
        }
       questionIndex()
        qCounter += 1
        counterLabel.text = String( qCounter ) + " of " + String(englishArray.count)
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

    
    func questionIndex()
    {
        nextBtn.isHidden = true
        let check  = Int(arc4random_uniform(UInt32(4)))
        
        
        
        randomNumber = Int(arc4random_uniform(UInt32(englishArray.count)))
        
        while(questionsIndexArray.contains(randomNumber))
        {
            randomNumber = Int(arc4random_uniform(UInt32(englishArray.count)))
        }
        questionsIndexArray.append(randomNumber)
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: mp3Array[randomNumber], ofType: "mp3")!) as URL)
        randomNumber2 = Int(arc4random_uniform(UInt32(englishArray.count)))
        randomNumber3 = Int(arc4random_uniform(UInt32(englishArray.count)))
        randomNumber4 = Int(arc4random_uniform(UInt32(englishArray.count)))
        
        checkArray.append(randomNumber)
        
        while(checkArray.contains(randomNumber2))
        {
            randomNumber2 = Int(arc4random_uniform(UInt32(englishArray.count)))
        }
        checkArray.append(randomNumber2)
        
        while(checkArray.contains(randomNumber3))
        {
            randomNumber3 = Int(arc4random_uniform(UInt32(englishArray.count)))
        }
        checkArray.append(randomNumber3)
        
        while(checkArray.contains(randomNumber4))
        {
            randomNumber4 = Int(arc4random_uniform(UInt32(englishArray.count)))
        }
        checkArray.append(randomNumber4)
        
        print(randomNumber , randomNumber2 , randomNumber3 , randomNumber4)
        
        if(check == 0)
        {
            labelOne.text = englishArray[randomNumber]
            labelOne.adjustsFontSizeToFitWidth = true
            labelOne.tag = randomNumber
            imageOne.tag = randomNumber
            labelTwo.text = englishArray[randomNumber2]
            labelTwo.adjustsFontSizeToFitWidth = true
            labelTwo.tag = randomNumber2
            imageTwo.tag = randomNumber2
            labelThree.text = englishArray[randomNumber3]
            labelThree.adjustsFontSizeToFitWidth = true
            labelThree.tag = randomNumber3
            imageThree.tag = randomNumber3
            labelFour.text = englishArray[randomNumber4]
            labelFour.adjustsFontSizeToFitWidth = true
            labelFour.tag = randomNumber4
            imageFour.tag = randomNumber4
            
        }
        else if(check == 1)
        {
            labelOne.text = englishArray[randomNumber2]
            labelOne.adjustsFontSizeToFitWidth = true
            labelOne.tag = randomNumber2
            imageOne.tag = randomNumber2
            labelTwo.text = englishArray[randomNumber]
            labelTwo.adjustsFontSizeToFitWidth = true
            labelTwo.tag = randomNumber
            imageTwo.tag = randomNumber
            labelThree.text = englishArray[randomNumber3]
            labelThree.adjustsFontSizeToFitWidth = true
            labelThree.tag = randomNumber3
            imageThree.tag = randomNumber3
            labelFour.text = englishArray[randomNumber4]
            labelFour.adjustsFontSizeToFitWidth = true
            labelFour.tag = randomNumber4
            imageFour.tag = randomNumber4
        }
        else if (check == 2)
        {
            labelOne.text = englishArray[randomNumber3]
            labelOne.adjustsFontSizeToFitWidth = true
            labelOne.tag = randomNumber3
            imageOne.tag = randomNumber3
            labelTwo.text = englishArray[randomNumber2]
            labelTwo.adjustsFontSizeToFitWidth = true
            labelTwo.tag = randomNumber2
            imageTwo.tag = randomNumber2
            labelThree.text = englishArray[randomNumber]
            labelThree.adjustsFontSizeToFitWidth = true
            labelThree.tag = randomNumber
            imageThree.tag = randomNumber
            labelFour.text = englishArray[randomNumber4]
            labelFour.adjustsFontSizeToFitWidth = true
            labelFour.tag = randomNumber4
            imageFour.tag = randomNumber4
        }
        else if (check == 3)
        {
            labelOne.text = englishArray[randomNumber4]
            labelOne.adjustsFontSizeToFitWidth = true
            labelOne.tag = randomNumber4
            imageOne.tag = randomNumber4
            labelTwo.text = englishArray[randomNumber2]
            labelTwo.adjustsFontSizeToFitWidth = true
            labelTwo.tag = randomNumber2
            imageTwo.tag = randomNumber2
            labelThree.text = englishArray[randomNumber3]
            labelThree.adjustsFontSizeToFitWidth = true
            labelThree.tag = randomNumber3
            imageThree.tag = randomNumber3
            labelFour.text = englishArray[randomNumber]
            labelFour.adjustsFontSizeToFitWidth = true
            labelFour.tag = randomNumber
            imageFour.tag = randomNumber
        }
      
        
        checkArray.removeAll()
    }
    
    @IBAction func btnOneAction(_ sender: Any) {
        if(imageOne.tag == randomNumber)
        {
            imageOne.setImage(UIImage(named: "btnqcorrect.png"), for: .normal)
            nextBtn.isHidden = false
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            imageOne.setImage(UIImage(named: "btnquizwronge.png"), for: .normal)
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
      //  presentInterstitial()
    }
    
    @IBAction func btnTwoAction(_ sender: Any) {
        if(imageTwo.tag == randomNumber)
        {
            imageTwo.setImage(UIImage(named: "btnqcorrect.png"), for: .normal)
            nextBtn.isHidden = false
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            imageTwo.setImage(UIImage(named: "btnquizwronge.png"), for: .normal)
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
      //  presentInterstitial()
    }
    
    @IBAction func btnThreeAction(_ sender: Any) {
        if(imageThree.tag == randomNumber)
        {
            imageThree.setImage(UIImage(named: "btnqcorrect.png"), for: .normal)
            nextBtn.isHidden = false
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            imageThree.setImage(UIImage(named: "btnquizwronge.png"), for: .normal)
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
    //    presentInterstitial()
        
    }
    @IBAction func btnFourAction(_ sender: Any) {
        if(imageFour.tag == randomNumber)
        {
            imageFour.setImage(UIImage(named: "btnqcorrect.png"), for: .normal)
            nextBtn.isHidden = false
            image.image = UIImage(named : "correct.png")
            image.isHidden = false
            imageOne.isEnabled = false
            imageTwo.isEnabled = false
            imageThree.isEnabled = false
            imageFour.isEnabled = false
        }
        else
        {
            imageFour.setImage(UIImage(named: "btnquizwronge.png"), for: .normal)
            image.image = UIImage(named : "cross.png")
            image.isHidden = false
        }
      //  presentInterstitial()
        
    }
    
    @IBAction func nextQuestionAction(_ sender: Any) {
        if(englishArray.count == questionsIndexArray.count)
        {
            let alertController = UIAlertController(title: "Completed", message: "Quiz Completed", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                let transition = CATransition()
                transition.duration = 0.4
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                self.view.window!.layer.add(transition, forKey: nil)
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
                self.navigationController?.pushViewController(viewController!, animated: false)
            }
            self.present(alertController, animated: false)
            alertController.addAction(OKAction)
        }
        else
        {
            image.isHidden = true
            imageOne.setImage(UIImage(named: "btnqselect.png"), for: .normal)
            imageTwo.setImage(UIImage(named: "btnqselect.png"), for: .normal)
            imageThree.setImage(UIImage(named: "btnqselect.png"), for: .normal)
            imageFour.setImage(UIImage(named: "btnqselect.png"), for: .normal)
            
            imageOne.isEnabled = true
            imageTwo.isEnabled = true
            imageThree.isEnabled = true
            imageFour.isEnabled = true
            
            questionIndex()
            qCounter += 1
            counterLabel.text = String(qCounter) + "  of  " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true

        }
      //  presentInterstitial()
    }
    @IBAction func playAction(_ sender: Any) {
        if(audio != nil)
        {
            if (!audio.isPlaying)
            {
                audio.play()
            }
        }
       // presentInterstitial()
    }
    @IBAction func back(_ sender: Any) {
        timer.invalidate()
        if(SecondViewController.staticVal.posFlag == true)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            self.view.window!.layer.add(transition, forKey: nil)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PartsOfSpeechViewController")
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
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
    }
}
