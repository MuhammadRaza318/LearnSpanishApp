//
//  PartsOfSpeechViewController.swift
//  LearnSpanish
//
//  Created by Zain on 16/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import GoogleMobileAds

class PartsOfSpeechViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    var timer = Timer()
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var topLabel: UILabel!
    var object = ArraysClass()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        self.topLabel.text = SecondViewController.staticVal.basicArray[SecondViewController.staticVal.index]
        self.topLabel.adjustsFontSizeToFitWidth = true
        bannerView.adUnitID = BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  object.pos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartOfSpeechCollectionViewCell", for: indexPath) as! PartOfSpeechCollectionViewCell
        cell.imageContent.image = UIImage(named: object.pos[indexPath.item ])
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.size.width / 2
        let height = self.collectionView.frame.size.height / 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presentInterstitial()
        SecondViewController.staticVal.posFlag = true
        if(indexPath.item == 0)
        {
            let alertController = UIAlertController(title: "Noun", message: "In English grammar, a noun is traditionally defined as the part of speech (or word class) that names or identifies a person, place, thing, quality, or activity. Adjective: nominal. Also called a substantive", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: false, completion: nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 1)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.dbTable = "noun"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
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
            SecondViewController.staticVal.dbTable = "noun"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 3)
        {
            let alertController = UIAlertController(title: "Verbs", message: "A verb is the part of speech (or word class) that describes an action or occurrence or indicates a state of being.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: false, completion: nil)
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
            SecondViewController.staticVal.dbTable = "verbs"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
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
            SecondViewController.staticVal.dbTable = "verbs"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 6)
        {
            let alertController = UIAlertController(title: "Pronoun", message: "In English grammar, a pronoun is a word that takes the place of a noun, noun phrase, or noun clause. The pronoun is one of the traditional parts of speech.  Adjective: pronominal.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: false, completion: nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 7)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.dbTable = "pronoun"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 8)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.dbTable = "pronoun"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 9)
        {
            let alertController = UIAlertController(title: "Adverb", message: "An adverb is the part of speech (or word class) that's primarily used to modify a verb, adjective, or other adverb. Adverbs can also modify prepositional phrases, subordinate clauses, and complete sentences", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: true, completion:nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 10)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.dbTable = "adverb"
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
            SecondViewController.staticVal.dbTable = "adverb"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 12)
        {
            let alertController = UIAlertController(title: "Adjective", message: "An adjective is the part of speech (or word class) that modifies a noun or a pronoun.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: true, completion:nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 13)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.dbTable = "adjective"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
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
            SecondViewController.staticVal.dbTable = "adjective"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 15)
        {
            let alertController = UIAlertController(title: "Preposition", message: "In English grammar, a preposition is a word (one of the parts of speech and a member of a closed word class) that shows the relationship between a noun or pronoun and other words in a sentence.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: true, completion:nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 16)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.dbTable = "prepositions"
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
            SecondViewController.staticVal.dbTable = "prepositions"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        else if (indexPath.item == 18)
        {
            let alertController = UIAlertController(title: "Conjunction", message: "A conjuntion is the part of speech (or word class) that serves to connect words, phrases, clauses, or sentences.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in
                
            }
            self.present(alertController, animated: true, completion:nil)
            alertController.addAction(OKAction)
        }
        else if (indexPath.item == 19)
        {
            let transition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.window!.layer.add(transition, forKey: nil)
            SecondViewController.staticVal.dbTable = "conjuction"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnViewController")
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
            SecondViewController.staticVal.dbTable = "conjuction"
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController")
            self.navigationController?.pushViewController(viewController!, animated: false)
        }
        
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
