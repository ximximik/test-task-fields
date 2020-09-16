//
//  AppDelegate.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import UIKit

private let inputPlistName = "input"

// Вместо dependecyInjection в этом проекте использовал синглтоны, чтобы не подключать библиотеки
public var initData: InitData = {
    var initData: InitData? = nil
    if let inputPlistUrl = Bundle.main.url(forResource: inputPlistName, withExtension: "plist"),
        let data = try? Data(contentsOf: inputPlistUrl) {
        
        let decoder = PropertyListDecoder()
        initData = try? decoder.decode(InitData.self, from: data)
    }
    return initData ?? InitData(scheme: [], data: [])
}()
public var peopleDataManager: PeopleDataManager = PeopleDataManagerDefault(data: initData.data)

// MARK: -
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

