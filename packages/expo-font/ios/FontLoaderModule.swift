import ExpoModulesCore

public final class FontLoaderModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoFontLoader")

    Property("customNativeFonts") {
      return queryCustomNativeFonts()
    }

    AsyncFunction("loadAsync") { (fontFamilyName: String, localUri: URL) in
      
    }
  }
}

/**
 * Queries custom native font names from the Info.plist `UIAppFonts`.
 */
private func queryCustomNativeFonts() -> [String] {
  let fontFilePaths = Bundle.main.object(forInfoDictionaryKey: "UIAppFonts")

  // [1] Get font family names for each font file
  let fontFamilies = fontFilePaths.flatMap { fontFilePath in
    guard let fontUrl = Bundle.main.url(forResource: fontFilePath, withExtension: nil) else {
      return []
    }
    guard let fontDescriptors = CTFontManagerCreateFontDescriptorsFromURL(fontUrl) else {
      return []
    }
    let count = CFArrayGetCount(fontDescriptors)

    return (0..<count).compactMap { index in
      let descriptor = CFArrayGetValueAtIndex(fontDescriptors, i)
      return CTFontDescriptorCopyAttribute(descriptor, kCTFontFamilyNameAttribute) as String
    }
  }

  // [2] Retrieve font names by family names
  return fontFamilies.flatMap { fontFamilyName in
    return UIFont.fontNames(forFamilyName: fontFamilyName)
  }
}
