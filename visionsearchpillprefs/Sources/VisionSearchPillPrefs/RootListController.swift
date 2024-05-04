/**
 * Copyright (c) 2024 Nightwind. All rights reserved.
 */

import VisionSearchPillPrefsC

@objc(VSPRootListController)
@objcMembers
class RootListController: PSListController {
    // Store the NSUserDefaults suite name
    private let suiteName: String! = "com.nightwind.visionsearchpillprefs"

    override var specifiers: NSMutableArray? {
        get {
            if let specifiers = value(forKey: "_specifiers") as? NSMutableArray {
                return specifiers
            } else {
                let specifiers = loadSpecifiers(fromPlistName: "Root", target: self)
                setValue(specifiers, forKey: "_specifiers")
                return specifiers
            }
        }
        set {
            super.specifiers = newValue
        }
    }

    override func setPreferenceValue(_ value: Any, specifier: PSSpecifier) {
        // Get the user defaults
        guard let prefs: UserDefaults = UserDefaults(suiteName: suiteName) else { return }

        // Set the value in the user defaults with a prefix to be able to identify the value
        prefs.setValue(value, forKey: "vsp_\(specifier.properties["key"] as! String)")
        // Send a notification to the main tweak notifying it of the change
		DistributedNotificationCenter.default().postNotificationName(Notification.Name("VisionSearchPillPreferenceSet"), object: nil, userInfo: nil, deliverImmediately: true)

        // Call the superclass implementation
        super.setPreferenceValue(value, specifier: specifier)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PSTableCell = super.tableView(tableView, cellForRowAt: indexPath) as! PSTableCell

        // If the cell is a contact cell, add the accessory arrow (chevron) to the cell for better UX.
        if cell.isKind(of: ContactCell.self) {
            cell.accessoryType = .disclosureIndicator
        }

        // If the cell is the banner cell, set its background color to clear.
        if cell.isKind(of: BannerCell.self) {
            cell.backgroundColor = .clear
        }

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the navbar settings gear icon
        self.initTopMenu()
    }

    /**
     * Opens a URL from a specified PSSpecifier's "url" property.
     *
     * @param sender - The specifier that contains the "url" property which will be opened.
     */
    func open(_ sender: PSSpecifier) {
        guard let url = URL(string: sender.properties["url"] as! String) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    /**
     * Initializes a gear icon in the navbar as the right bar button. When pressed, it invokes a menu that can then be used to reset the settings.
     */
    func initTopMenu() {
        // Initialize the actual button
        let topMenuButton: UIButton = UIButton(type: .custom)
        topMenuButton.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        topMenuButton.setImage(UIImage(systemName: "gearshape")?.withRenderingMode(.alwaysTemplate), for: .normal)
        topMenuButton.contentVerticalAlignment = .fill
        topMenuButton.contentHorizontalAlignment = .fill

        // Initialize the action that is used in the menu
        let resetPrefs = UIAction(title: "Reset Preferences", image: UIImage(systemName: "trash"), identifier: nil, handler: { _ in
            remLog("pressed reset prefs")
            self.performResetPrefs()
        })

        // Use the .destructive style to mark the action as red
        resetPrefs.attributes = .destructive

        // Initialize the menu
        topMenuButton.menu = UIMenu(title: "", children: [resetPrefs])
        topMenuButton.showsMenuAsPrimaryAction = true

        // Initialize the bar button is then used in the navbar
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: topMenuButton)
        self.navigationItem.rightBarButtonItem = barButton
    }

    /**
     * Shows an alert notifying the user if they want to reset the preferences of the tweak or not.
     */
    func performResetPrefs() {
        // Initialize alert
        let alert: UIAlertController = UIAlertController(title: "Reset Preferences?", message: "This cannot be undone", preferredStyle: .alert)

        // Initialize the cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        // Initialize the reset button action
        let resetAction: UIAlertAction = UIAlertAction(title: "Reset", style: .destructive, handler: { [weak self](_) in
            // Prevent retain cycle by using [weak self]
            guard let self = self else { return }

            // Remove the old settings
            UserDefaults.standard.removePersistentDomain(forName: self.suiteName)

            guard let specifiers = self.specifiers as? [PSSpecifier] else { return }

            // Initialize all the settings to the default ones
            for specifier in specifiers {
                if specifier.properties["default"] != nil {
                    self.setPreferenceValue(specifier.properties["default"] as Any, specifier: specifier)
                }
            }

            // Reload the table view so the user can see the settings change back to the default ones
            self.reload()
        })

        alert.addAction(resetAction)

        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
    }
}
