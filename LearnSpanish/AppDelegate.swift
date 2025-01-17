//
//  AppDelegate.swift
//  LearnSpanish
//
//  Created by Zain on 11/01/2017.
//  Copyright © 2017 Zain. All rights reserved.
//

import UIKit
import  StoreKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,SKProductsRequestDelegate {

    var window: UIWindow?
    var product: SKProduct? {
            didSet {
                NotificationCenter.default.post(name: NSNotification.Name("ProductPriceUpdated"), object: nil)
            }
        }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let productIdentifier = "spanishpro"
        purchaseProduct(withProductIdentifier: productIdentifier)
        return true
    }
    
    func purchaseProduct(withProductIdentifier productIdentifier: String) {
            if SKPaymentQueue.canMakePayments() {
                let productRequest = SKProductsRequest(productIdentifiers: Set([productIdentifier]))
                productRequest.delegate = self
                productRequest.start()
            } else {
                print("In-app purchases are disabled on this device.")
            }
        }

        // MARK: - SKProductsRequestDelegate

        func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
            if response.products.count > 0 {
                print("Product is available")
                self.product = response.products.first
                NotificationCenter.default.post(name: NSNotification.Name("ProductPriceUpdated"), object: nil)
            } else {
                print("Product is not available")
            }
        }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

