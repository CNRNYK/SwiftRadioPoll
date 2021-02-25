//
//  AppDelegate.swift
//  Swift Radio
//
//  Created by Matthew Fecher on 7/2/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit
import Pendo.PendoManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    weak var stationsViewController: StationsViewController?
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        if url.scheme?.range(of: "pendo") != nil {
            PendoManager.shared().initWith(url)
            
            return true
        }
        // your code here...
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
       

        
        
        let initParams = PendoInitParams()
        initParams.visitorId = "CNVisitorID"
        initParams.visitorData = ["key": "value", "Country": "USA", "Gender": "Male"]
        initParams.accountId = "CNAccountID"
        initParams.accountData = ["key": "value", "Timezone": "EST", "Size": "Enterprise"]

        // *************** Aşağıdaki tek satır kodu silebilirsin ********
        PendoManager.shared().track("event_name", properties: ["key1":"val1", "key2":"val2"])

        
        PendoManager.shared().initSDK(
            "eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJkYXRhY2VudGVyIjoidXMiLCJrZXkiOiIwYjRhMjdmZWY1N2E3ZDA4MzVjZGJjOTMyNDNiYTU5MWZjNzI5Njc0OGI0YTBjYWYwMmMyZjk5ZGY1MGIxYzFhZDYzZTVlYzk4NzRlOTVjMWEwODJiOGUzYmJmMWNjMGM3N2JhM2QzYThmOTc5MDNlOGViMzUwN2I1MWE2ZDhmOS5mNTdkN2IyNDBjZWEyZmJmZWM2MDk0Nzc1NmJkNzZjZi4zMzIzNjRhY2JmNDE5Y2RjZDE4MDllMDQ1NWFiNTllY2ViMTk4YzA0OTEwMjU5ZjZkZDdlNTcwZmU3ZTY1MGFkIn0.BCFi8fLkAJYMGS3GgfhT5l7bVTtQpOKtLVilnSUPT9OY7T8BUQz59DLH5CNky2eykfpyeyUO2Zo0yWVxrLFvT1iznN-BLECZX4LrIv0TuatFkEFrbunuygiGcEYyxERX3C8nXCH7ZH8lMsIiHMt5Xl-kL1jPKUvrgbT4iyecsyc",
            initParams: initParams) // call initSDK with initParams as a 2nd parameter.
        
    
        // MPNowPlayingInfoCenter
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        // Make status bar white
        UINavigationBar.appearance().barStyle = .black
        
        // FRadioPlayer config
        FRadioPlayer.shared.isAutoPlay = true
        FRadioPlayer.shared.enableArtwork = true
        FRadioPlayer.shared.artworkSize = 600
        
        // Get weak ref of StationsViewController
        if let navigationController = window?.rootViewController as? UINavigationController {
            stationsViewController = navigationController.viewControllers.first as? StationsViewController
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        UIApplication.shared.endReceivingRemoteControlEvents()
        
    }
    
    // MARK: - Remote Controls

    override func remoteControlReceived(with event: UIEvent?) {
        super.remoteControlReceived(with: event)
        
        guard let event = event, event.type == UIEventType.remoteControl else { return }
        
        switch event.subtype {
        case .remoteControlPlay:
            FRadioPlayer.shared.play()
        case .remoteControlPause:
            FRadioPlayer.shared.pause()
        case .remoteControlTogglePlayPause:
            FRadioPlayer.shared.togglePlaying()
        case .remoteControlNextTrack:
            stationsViewController?.didPressNextButton()
        case .remoteControlPreviousTrack:
            stationsViewController?.didPressPreviousButton()
        default:
            break
        }
    }
}

