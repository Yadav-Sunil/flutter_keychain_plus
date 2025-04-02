import Flutter
import UIKit
import Security

private let KEYCHAIN_SERVICE = "flutter_keychain_plus"
private let CHANNEL_NAME = "flutter_keychain_plus"

public class FlutterKeychainPlusPlugin: NSObject, FlutterPlugin {
    private let query: [CFString: Any] = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: KEYCHAIN_SERVICE
    ]
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = FlutterKeychainPlusPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String: Any] ?? [:]
        let key = args["key"] as? String ?? ""
        switch call.method {
        case "get":
            guard let value = args["key"] as? String else {
                result(FlutterError(code: "InvalidArguments", message: "Missing key parameter", details: nil))
                return
            }
            result(get(key: key))
        case "put":
            guard let value = args["key"] as? String else {
                result(FlutterError(code: "InvalidArguments", message: "Missing key parameter", details: nil))
                return
            }
            guard let value = args["value"] as? String else {
                result(FlutterError(code: "InvalidArguments", message: "Missing value parameter", details: nil))
                return
            }
            put(value: value, forKey: key)
            result(nil)
        case "remove":
            guard let value = args["key"] as? String else {
                result(FlutterError(code: "InvalidArguments", message: "Missing key parameter", details: nil))
                return
            }
            remove(key: key)
            result(nil)
        case "clear":
            clear()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
    
    private func put(value: String, forKey key: String) {
        var search = query
        search[kSecAttrAccount] = key
        search[kSecMatchLimit] = kSecMatchLimitOne
        
        var status = SecItemCopyMatching(search as CFDictionary, nil)
        if status == errSecSuccess {
            let update: [CFString: Any] = [kSecValueData: value.data(using: .utf8)!]
            status = SecItemUpdate(search as CFDictionary, update as CFDictionary)
        } else {
            search[kSecValueData] = value.data(using: .utf8)
            search[kSecMatchLimit] = nil
            status = SecItemAdd(search as CFDictionary, nil)
        }
        
        if status != errSecSuccess {
            print("Keychain operation failed with status: \(status)")
        }
    }
    
    private func get(key: String) -> String? {
        var search = query
        search[kSecAttrAccount] = key
        search[kSecReturnData] = kCFBooleanTrue
        
        var resultData: AnyObject?
        let status = SecItemCopyMatching(search as CFDictionary, &resultData)
        
        if status == errSecSuccess, let data = resultData as? Foundation.Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    private func remove(key: String) {
        var search = query
        search[kSecAttrAccount] = key
        SecItemDelete(search as CFDictionary)
    }
    
    private func clear() {
        SecItemDelete(query as CFDictionary)
    }
}
