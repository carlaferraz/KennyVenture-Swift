import SwiftUI
import UIKit

@main
struct MyApp: App {
    
    init(){
        //Mudar o nome da fonte na pasta de recursos do playground e a extensão dela
        let cfURL = Bundle.main.url(forResource: "SourGummy", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        var fontNames: [[AnyObject]] = []
        for name in UIFont.familyNames {
            print(name)
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
