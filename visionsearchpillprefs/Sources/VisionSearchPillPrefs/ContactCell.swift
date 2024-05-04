/**
 * Copyright (c) 2024 Nightwind. All rights reserved.
 */

import VisionSearchPillPrefsC

@objc(VSPContactCell)
@objcMembers
class ContactCell: PSTableCell {
	// The image view of the contact cell
	private var customImageView: UIImageView!
	// The username to be displayed
	private var usernameLabel: UILabel!
	// The handle to be displayed
	private var handleLabel: UILabel!

	convenience required init?(coder decoder: NSCoder) {
		self.init(coder: decoder)
	}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String, specifier: PSSpecifier) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

		// Get the image from the specifier
		guard let imageName = specifier.properties["image"] as? String else { return }
		guard let image = UIImage(named: imageName, in: Bundle(for: ContactCell.self), compatibleWith: nil) else { return }

		// Get the username from the specifier
		guard let titleText = specifier.properties["titleLabel"] as? String else { return }
		// Get the handle from the specifier
		guard let bottomText = specifier.properties["bottomLabel"] as? String else { return }

		// Initialize the image view
		customImageView = UIImageView(image: image)
		customImageView.layer.masksToBounds = true
		customImageView.layer.cornerRadius = 10.0
		customImageView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(customImageView)

		// Initialize the username label
		usernameLabel = UILabel()
		usernameLabel.text = titleText
		usernameLabel.font = .boldSystemFont(ofSize: 15.0)
		usernameLabel.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(usernameLabel)

		// Intiialize the handle label
		handleLabel = UILabel()
		handleLabel.text = bottomText
		handleLabel.textColor = .secondaryLabel
		handleLabel.font = .systemFont(ofSize: 11.0)
		handleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(handleLabel)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		// Position all the subviews relative to one another
		NSLayoutConstraint.activate([
			customImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			customImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
			customImageView.heightAnchor.constraint(equalToConstant: 40),
			customImageView.widthAnchor.constraint(equalToConstant: 40),

			usernameLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -18),
			usernameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20),

			handleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 18),
			handleLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
			handleLabel.heightAnchor.constraint(equalToConstant: 20),
		])
	}
}