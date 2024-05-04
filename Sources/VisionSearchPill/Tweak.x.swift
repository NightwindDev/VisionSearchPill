/**
 * Copyright (c) 2024 Nightwind. All rights reserved.
 */

import Orion
import VisionSearchPillC

class PillHook: ClassHook<SBHSearchPillView> {
	func didMoveToWindow() {
		orig.didMoveToWindow()

		// Apply changes without respring
		DistributedNotificationCenter.default().addObserver(forName: Notification.Name("VisionSearchPillPreferenceSet"), object: nil, queue: .main) { _ in
			self.target.applyVisionStyle()
		}
	}

	func layoutSubviews() {
		orig.layoutSubviews()
		target.applyVisionStyle()
	}

	/**
	 *	Apply the VisionOS style to the search pill.
	 */
	// orion:new
	@objc func applyVisionStyle() {
		// Load the settings of the tweak
		do {
			try	TweakPreferences.shared.loadSettings()
		} catch {
			remLog("error: \(error.localizedDescription)")
			return
		}

		// Store the settings
		let tweakEnabled: Bool = TweakPreferences.shared.settings.tweakEnabled
		let borderWidth: CGFloat = TweakPreferences.shared.settings.borderWidth

		let backgroundColor: UIColor = TweakPreferences.shared.colorFor(key: "backgroundColor", fallback: "#ffffffff")
		let borderColor: UIColor = TweakPreferences.shared.colorFor(key: "borderColor", fallback: "#ffffffff")

		// Apply the style
		guard let backgroundView = target.backgroundView else { return }
		backgroundView.layer.borderWidth = tweakEnabled ? borderWidth : 0
		backgroundView.layer.borderColor = tweakEnabled ? borderColor.cgColor : UIColor.clear.cgColor
		backgroundView.alpha = tweakEnabled ? 0.1 : 1

		target.alpha = tweakEnabled ? 0.1 : 1
		target.backgroundColor = tweakEnabled ? backgroundColor : .clear
		target.layer.cornerRadius = tweakEnabled ? backgroundView.layer.cornerRadius : 0
		target.clipsToBounds = tweakEnabled ? true : false
	}
}

class BackgroundPillHook: ClassHook<SBFolderScrollAccessoryView> {
	func didMoveToWindow() {
		orig.didMoveToWindow()
		target.applyVisionStyle()

		// Apply changes without respring
		DistributedNotificationCenter.default().addObserver(forName: Notification.Name("VisionSearchPillPreferenceSet"), object: nil, queue: .main) { _ in
			self.target.applyVisionStyle()
		}
	}

	/**
	 *	Apply the VisionOS style to the search pill
	 */
	// orion:new
	@objc func applyVisionStyle() {
		// Load the settings of the tweak
		do {
			try	TweakPreferences.shared.loadSettings()
		} catch {
			remLog("error: \(error.localizedDescription)")
			return
		}

		// Store the settings
		let tweakEnabled: Bool = TweakPreferences.shared.settings.tweakEnabled
		let borderWidth: CGFloat = TweakPreferences.shared.settings.borderWidth

		let backgroundColor: UIColor = TweakPreferences.shared.colorFor(key: "backgroundColor", fallback: "#ffffffff")
		let borderColor: UIColor = TweakPreferences.shared.colorFor(key: "borderColor", fallback: "#ffffffff")

		// Apply the style
		guard let backgroundView = target.backgroundView else { return }
		backgroundView.layer.borderWidth = tweakEnabled ? borderWidth : 0
		backgroundView.layer.borderColor = tweakEnabled ? borderColor.cgColor : UIColor.clear.cgColor
		backgroundView.alpha = tweakEnabled ? 0.1 : 1
		backgroundView.backgroundColor = tweakEnabled ? backgroundColor : .clear
	}
}

class VisionSearchPill: Tweak {
	required init() {
		remLog("VisionSearchPill starting")
		do {
			try TweakPreferences.shared.loadSettings()
		} catch {
			remLog("Unexpected error: \(error.localizedDescription)")
		}
	}

	static func handleError(_ error: OrionHookError) {
		remLog(error)
		DefaultTweak.handleError(error)
	}
}