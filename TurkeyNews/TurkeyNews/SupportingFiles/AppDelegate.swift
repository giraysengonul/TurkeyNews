//
//  AppDelegate.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 6.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        saveAPIKeyFromConfigIfNeeded()
        return true
    }
    // MARK: - Save APIKEY
      private func saveAPIKeyFromConfigIfNeeded() {
          if KeychainWrapper.shared.load(key: "APIKEY") == nil {
              
              guard let config = readConfigFromPlist() else {
                  fatalError("The config file could not be found or read.")
              }
              
              guard let apiKey = config["APIKEY"] as? String else {
                  fatalError("API key not found in configuration file.")
              }
              
              guard !KeychainWrapper.shared.saveAPIKey(key: "APIKEY", value: apiKey) else{
                  return
              }
              
              print("APIKEY SAVE ERROR")
          }
      }
      
      /// Read Config.infoplist
      /// - Returns: Dictionary or nil
      func readConfigFromPlist() -> [String: Any]? {
          guard let path = Bundle.main.path(forResource: "Config", ofType: "plist") else {
              return nil
          }
          guard let configDict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
              return nil
          }
          return configDict
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

