//
//  UserDefaultUtils.swift
//  GitHubRepositories
//
//  Created by mihmouda on 16/06/2023.
//

import Foundation

enum UserDefaultKey: String {
   case favoriteList = "favorite_list"
}

class UserDefaultUtils {
   
   /**
    Removes a value from UserDefaults.
    
    - Parameter key: The key associated with the value to be removed.
    */
   class func removeValue(_ key: UserDefaultKey){
       UserDefaults.standard.removeObject(forKey: key.rawValue)
       UserDefaults.standard.synchronize()
   }
   
   /**
    Sets a value in UserDefaults for a given key.
    
    - Parameters:
       - value: The value to be stored.
       - key: The key associated with the value.
    */
   class func setObjectValue(_ value : Any!, forKey key : UserDefaultKey) {
       UserDefaults.standard.set(value, forKey: key.rawValue)
       UserDefaults.standard.synchronize()
   }
   
   /**
    Retrieves a value from UserDefaults for a given key.
    
    - Parameter key: The key associated with the value.
    - Returns: The value associated with the key, or `nil` if the key does not exist.
    */
   class func getObjectValueForKey(_ key : UserDefaultKey) -> Any? {
       if let value = UserDefaults.standard.object(forKey: key.rawValue) {
           return value
       }
       
       return nil
   }
}

