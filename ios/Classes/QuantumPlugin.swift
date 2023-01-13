import Flutter
import UIKit

public class QuantumPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "quantum", binaryMessenger: registrar.messenger())
    let instance = QuantumPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let fts5Simple = Fts5Simple()
    fts5Simple.someMethod()
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
