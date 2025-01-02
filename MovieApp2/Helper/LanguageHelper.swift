import Foundation

struct LanguageHelper {
    static let languageMap: [String: String] = [
        "en": "English",
        "fr": "French",
        "es": "Spanish",
        "de": "German",
        "it": "Italian",
        "ru": "Russian",
        "ja": "Japanese",
        "ko": "Korean",
        "zh": "Chinese",
        "ar": "Arabic",
        "pt": "Portuguese",
        "hi": "Hindi",
        "bn": "Bengali",
        "tr": "Turkish",
        "pl": "Polish",
        "sv": "Swedish",
        "da": "Danish",
        "no": "Norwegian",
        "fi": "Finnish",
        "nl": "Dutch",
        "el": "Greek",
        "cs": "Czech",
        "hu": "Hungarian",
        "th": "Thai",
        "vi": "Vietnamese",
        "he": "Hebrew",
        "uk": "Ukrainian",
        "id": "Indonesian"
    ]
    
    static func languageName(for code: String?) -> String {
        guard let code = code, !code.isEmpty else {
            return "Unknown Language"
        }
        return languageMap[code] ?? code
    }
}
