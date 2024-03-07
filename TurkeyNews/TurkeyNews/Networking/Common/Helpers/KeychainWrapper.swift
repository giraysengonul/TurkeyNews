//
//  KeychainWrapper.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
import Security

/// Keychain Process
final class KeychainWrapper {
    /// Singleton
    static let shared = KeychainWrapper()
    
    /// Init
    private init() {}
    
    /// Keychain Save Process
    /// - Parameters:
    ///   - key: Key
    ///   - value: Value
    /// - Returns: True or False
    public func saveAPIKey(key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary
        
        // If there is a previously saved value, delete it
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        return status == errSecSuccess
    }
    
    /// Keychain Get Value Process
    /// - Parameter key: Key
    /// - Returns: String value or nil
    public func getAPIKey(key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        guard status == errSecSuccess,
              let apiKeyData = result as? Data,
              let apiKey = String(data: apiKeyData, encoding: .utf8) else {
            return nil
        }
        
        return apiKey
    }
    
    /// Keyychain Delete Process
    /// - Parameter key: Key
    /// - Returns: True or False
    public func deleteAPIKey(key: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        return status == errSecSuccess
    }
    
    
    /// Checking if it has been registered before
    /// - Parameter key: Key
    /// - Returns: Data or nil
    public func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }
}
