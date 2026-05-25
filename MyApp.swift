import SwiftUI
import UIKit
import CoreText

@main
struct MyApp: App {
    
    init(){
        if let cfURL = Bundle.main.url(forResource: "SourGummy", withExtension: "ttf") as CFURL? {
            CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        } else {
            print("Warning: SourGummy.ttf not found in bundle")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
