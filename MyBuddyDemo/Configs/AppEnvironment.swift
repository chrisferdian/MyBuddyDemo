//
//  AppEnvironment.swift
//  MyBuddyDemo

import Foundation

public enum AppEnvironment {
    
    /// a enum to centralize all keys
    private enum Keys: String {
        case googlePlist = "GOOGLE_PLIST"
        case productName = "PRODUCT_NAME"
    }
    
    /// If cannot find Info.plist, simply crash as it is a developer error and should never happen
    private static let infoDictionary: [String: Any] = Bundle.main.infoDictionary!
    
    static var googlePlist: String {
        guard let relativePath = infoDictionary[Keys.googlePlist.rawValue] as? String else {
            fatalError("GOOGLE_PLIST key is missing in Info.plist!")
        }
        
        // Resolve full path using bundle's resource path
        guard let resourcePath = Bundle.main.resourcePath else {
            fatalError("Bundle resource path is nil!")
        }
        
        return (resourcePath as NSString).appendingPathComponent(relativePath)
    }
    
    static var productName: String {
        guard let _productName = infoDictionary[Keys.productName.rawValue] as? String else {
            fatalError("PRODUCT_NAME key is missing")
        }
        return _productName
    }
}
