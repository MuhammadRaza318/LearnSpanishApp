//
//  ListningQuizViewController.swift
//  LearnSpanish
//
//  Created by Zain on 17/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ListningQuizViewController: UIViewController , GADBannerViewDelegate {

    @IBOutlet weak var topView: UIView!
  
    var randomNumber = 0
    var randomNumber2 = 0
    var randomNumber3 = 0
    var randomNumber4 = 0
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var imageOne: UIButton!
    @IBOutlet weak var imageTwo: UIButton!
    @IBOutlet weak var imageThree: UIButton!
    @IBOutlet weak var imageFour: UIButton!
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var upperlabel: UILabel!
    
    var timer = Timer()
    var counter = 0
    var englishArray : [String] = []
    var spanishArray : [String] = []
    var checkArray : [Int] = []
    var questionsIndexArray : [Int] = []
    var qCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData(table: MainCollectionViewController.staticVal.dbTable)
        if(SecondViewController.staticVal.backFlagCheck == true)
        {
            self.topLabel.text = "Listening Quiz-" + SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
            self.topLabel.adjustsFontSizeToFitWidth = true
        }
        else
        {
            self.topLabel.text = "Listening Quiz-" + MainCollectionViewController.staticVal.labelsArray[MainCollectionViewController.staticVal.mainIndex]
           self.topLabel.adjustsFontSizeToFitWidth = true
        }
        if(SecondMenuCollectionViewController.staticVal.checkFlag == true)
        {
            upperlabel.text = "Spanish To English"
            upperlabel.adjustsFontSizeToFitWidth = true
        }
        else
        {
            upperlabel.text = "English To Spanish"
            upperlabel.adjustsFontSizeToFitWidth = true
        }
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
     
            let queryResultCol2 = sqlite3_column_text(queryStatement, 1)
            let spanishName  = String.init(cString: queryResultCol2!)
           
            let queryResultCol3 = sqlite3_column_text(queryStatement, 0)
            let engName = String.init(cString: queryResultCol3!)
         
            englishArray.append(engName)
            spanishArray.append(spanishName)
       }
        qCounter += 1
        questionIndex()
        
        
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
        if(SecondMenuCollectionViewController.staticVal.checkFlag == false)
        {
            questionLabel.text = "Q" + String(qCounter) + ": " + englishArray[randomNumber]
        }
        else
        {
           questionLabel.text = "Q" + String(qCounter) + ": " + spanishArray[randomNumber]
        }
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
            if(SecondMenuCollectionViewController.staticVal.checkFlag == false)
            {
                labelOne.text = spanishArray[randomNumber]
                labelOne.adjustsFontSizeToFitWidth = true
                labelOne.tag = randomNumber
                imageOne.tag = randomNumber
                labelTwo.text = spanishArray[randomNumber2]
                labelTwo.adjustsFontSizeToFitWidth = true
                labelTwo.tag = randomNumber2
                imageTwo.tag = randomNumber2
                labelThree.text = spanishArray[randomNumber3]
                labelThree.adjustsFontSizeToFitWidth = true
                labelThree.tag = randomNumber3
                imageThree.tag = randomNumber3
                labelFour.text = spanishArray[randomNumber4]
                labelFour.adjustsFontSizeToFitWidth = true
                labelFour.tag = randomNumber4
                imageFour.tag = randomNumber4
            }
            else
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
            
            
        }
        else if(check == 1)
        {
            if(SecondMenuCollectionViewController.staticVal.checkFlag == false)
            {
                labelOne.text = spanishArray[randomNumber2]
                labelOne.adjustsFontSizeToFitWidth = true
                labelOne.tag = randomNumber2
                imageOne.tag = randomNumber2
                labelTwo.text = spanishArray[randomNumber]
                labelTwo.adjustsFontSizeToFitWidth = true
                labelTwo.tag = randomNumber
                imageTwo.tag = randomNumber
                labelThree.text = spanishArray[randomNumber3]
                labelThree.adjustsFontSizeToFitWidth = true
                labelThree.tag = randomNumber3
                imageThree.tag = randomNumber3
                labelFour.text = spanishArray[randomNumber4]
                labelFour.adjustsFontSizeToFitWidth = true
                labelFour.tag = randomNumber4
                imageFour.tag = randomNumber4
            }
            else
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
            
        }
        else if (check == 2)
        {
            if(SecondMenuCollectionViewController.staticVal.checkFlag == false)
            {
                labelOne.text = spanishArray[randomNumber3]
                labelOne.adjustsFontSizeToFitWidth = true
                labelOne.tag = randomNumber3
                imageOne.tag = randomNumber3
                labelTwo.text = spanishArray[randomNumber2]
                labelTwo.adjustsFontSizeToFitWidth = true
                labelTwo.tag = randomNumber2
                imageTwo.tag = randomNumber2
                labelThree.text = spanishArray[randomNumber]
                labelThree.adjustsFontSizeToFitWidth = true
                labelThree.tag = randomNumber
                imageThree.tag = randomNumber
                labelFour.text = spanishArray[randomNumber4]
                labelFour.adjustsFontSizeToFitWidth = true
                labelFour.tag = randomNumber4
                imageFour.tag = randomNumber4
            }
            else
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
            
        }
        else if (check == 3)
        {
            if(SecondMenuCollectionViewController.staticVal.checkFlag == false)
            {
                labelOne.text = spanishArray[randomNumber4]
                labelOne.adjustsFontSizeToFitWidth = true
                labelOne.tag = randomNumber4
                imageOne.tag = randomNumber4
                labelTwo.text = spanishArray[randomNumber2]
                labelTwo.adjustsFontSizeToFitWidth = true
                labelTwo.tag = randomNumber2
                imageTwo.tag = randomNumber2
                labelThree.text = spanishArray[randomNumber3]
                labelThree.adjustsFontSizeToFitWidth = true
                labelThree.tag = randomNumber3
                imageThree.tag = randomNumber3
                labelFour.text = spanishArray[randomNumber]
                labelFour.adjustsFontSizeToFitWidth = true
                labelFour.tag = randomNumber
                imageFour.tag = randomNumber
            }
            else
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
            
        }
        
        
        checkArray.removeAll()
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
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondMenuCollectionViewController")
                self.navigationController?.pushViewController(viewController!, animated: false)
            }
            self.present(alertController, animated: true, completion:nil)
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
            
            qCounter += 1
            questionIndex()
            counterLabel.text = String(qCounter) + "  of  " + String(englishArray.count)
            counterLabel.adjustsFontSizeToFitWidth = true
            
            
        }
     //   presentInterstitial()

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
      ///presentInterstitial()
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
       /// presentInterstitial()
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
      //  presentInterstitial()
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
   //     presentInterstitial()
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
}
