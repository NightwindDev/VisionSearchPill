/**
 * Copyright (c) 2024 Nightwind. All rights reserved.
 */

import Foundation
import GcUniversal

// Store the tweak settings in a Codable struct in order to group them together
struct Settings: Codable {
	var tweakEnabled: Bool = true
	var borderWidth: CGFloat = 1.0
}

@objc(VSPTweakPreferences)
@objcMembers
final class TweakPreferences: NSObject {
	// Store the tweak settings in a readonly struct that can be accessed from the outside
	private(set) var settings: Settings!
	// Shared instance of TweakPreferences for convenience
	static let shared = TweakPreferences()

	private let userDefaultsName: String = "com.nightwind.visionsearchpillprefs"

	/**
	 * Loads the tweak settings from NSUserDefaults to the settings Codable struct.
	 */
	@objc(loadSettingsWithError:)
	func loadSettings() throws {
		// If defaults haven't been set yet, set self.settings to the default values
		guard let prefs: UserDefaults = UserDefaults(suiteName: userDefaultsName) else {
			self.settings = Settings()
			return
		}

		// Get the dictionary representation of the user defaults
		let dict = prefs.dictionaryRepresentation()
		// Make a dictionary that can be used with the Codable struct
		let codableDict = NSMutableDictionary()

		// Loop over the dictionary and only take out the keys that correspond with the actual VisualSearchPill settings
		for (key, value) in dict {
			if key.hasPrefix("vsp_") {
				codableDict.setValue(value, forKey: key.components(separatedBy: "vsp_")[1])
			}
		}

		// Get a JSON representation of the Codable dictionary
		let data = try JSONSerialization.data(withJSONObject: codableDict, options: [.fragmentsAllowed, .prettyPrinted])

		// Decode the JSON representation to self.settings. If successful, self.settings is set to the loaded settings.
		// Otherwise, self.settings is set to the default settings
		if let loadedSettings = try? JSONDecoder().decode(Settings.self, from: data) {
			self.settings = loadedSettings
		} else {
			self.settings = Settings()
		}
	}

	/**
	 * Get the color from the preferences.
	 *
	 * @param key - The internal key that identifies the color in the preference bundle.
	 * @param fallback - The fallback hex value to use if the color is not available. This argument is optional.
	 *
	 * @return The color from the preferences.
	 */
	@objc(colorForKey:fallback:)
	func colorFor(key: String, fallback: String? = nil) -> UIColor {
		return GcColorPickerUtils.color(fromDefaults: userDefaultsName, withKey: key, fallback: fallback)
	}

}