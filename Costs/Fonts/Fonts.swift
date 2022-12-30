//    "JetBrainsMono-Regular", "JetBrainsMono-Thin", "JetBrainsMono-Bold"

import SwiftUI

extension Font {
    
    public static var jbTitle: Font {
        return Font.custom("JetBrainsMono-Regular", size: 40)
    }
    
    public static var jbSubTitle: Font {
        return Font.custom("JetBrainsMono-Regular", size: 28)
    }
    
    public static var jbBody: Font {
        return Font.custom("JetBrainsMono-Regular", size: 16)
    }
    
    public static var jbBodyLarge: Font {
        return Font.custom("JetBrainsMono-Regular", size: 20)
    }
    
    public static var jbNumberInput: Font {
        return Font.custom("JetBrainsMono-Thin", size: 24)
    }
    
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        return Font.custom(fontName(weight: weight), size: size)
    }
    
    public static func fontName(weight: Font.Weight) -> String {
        var font = "JetBrainsMono-Regular"
        switch weight {
        case .bold: font = "JetBrainsMono-Bold"
        case .thin: font = "JetBrainsMono-Thin"
        default: break
        }
        return font;
    }
}
