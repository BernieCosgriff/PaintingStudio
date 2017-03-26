//
//  AppDelegate.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/14/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PaintingCollectionDelegate{

    var window: UIWindow?
    private var navigationController_: UINavigationController! = nil
    private var collection_ = PaintingCollection()
    private var collectionViewController_: PaintingCollectionViewController! = nil


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        collection_.delegate = self
        collectionViewController_ = PaintingCollectionViewController(paintingCollection: collection_)
        navigationController_ = UINavigationController(rootViewController: collectionViewController_)
        window?.rootViewController = navigationController_
        return true
    }
    
    func paintingSelected(){
        navigationController_.pushViewController(PaintingViewController(paintingCollection: collection_), animated: true)
    }
    
    func paintingRemoved(index: Int) {
        if let cell = collectionViewController_.collectionView_.cellForItem(at: IndexPath(row: index, section: 0)) {
            for view in cell.subviews {
                if(view is CellView){
                    view.removeFromSuperview()
                }
            }
        }
        collectionViewController_.collectionView_.deleteItems(at: [IndexPath(row: index, section: 0)])
        navigationController_.popViewController(animated: true)
    }
    
    func reloadPainting(index: Int) {
        if let cell = collectionViewController_.collectionView_.cellForItem(at: IndexPath(row: index, section: 0)){
            for view in cell.subviews {
                view.setNeedsDisplay()
            }
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

