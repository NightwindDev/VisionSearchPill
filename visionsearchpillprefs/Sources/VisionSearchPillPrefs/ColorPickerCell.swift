/**
 * Copyright (c) 2024 Nightwind. All rights reserved.
 */

import VisionSearchPillPrefsC

@objc(VSPColorPickerCell)
@objcMembers
class ColorPickerCell: GcColorPickerCell {
	override func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController?) {
		// Call the superclass's implementation
		super.colorPickerViewControllerDidFinish(viewController)
        // Send a notification to the main tweak notifying it of the change
		DistributedNotificationCenter.default().postNotificationName(Notification.Name("VisionSearchPillPreferenceSet"), object: nil, userInfo: nil, deliverImmediately: true)
	}
}