/**
 * Copyright (c) 2024 Nightwind. All rights reserved.
 */

import VisionSearchPillPrefsC

@objc(VSPBannerCell)
@objcMembers
class BannerCell: PSTableCell {
	convenience required init?(coder decoder: NSCoder) {
		self.init(coder: decoder)
	}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String, specifier: PSSpecifier) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

		// Make sure the cell is not interactive
		self.isUserInteractionEnabled = false

		// Get the name of the tweak from the specifier's properties
		guard let tweakName = specifier.properties["tweakTitle"] as? String else { return }

		// Initialize the version subtitle label
		let versionSubtitle: UILabel = UILabel()
		versionSubtitle.text = kPackageVersion
		versionSubtitle.font = .systemFont(ofSize: 22.0)
		versionSubtitle.textColor = .secondaryLabel
		versionSubtitle.textAlignment = .center
		versionSubtitle.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(versionSubtitle)

		// Position the subtitle label
		NSLayoutConstraint.activate([
			versionSubtitle.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
			versionSubtitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
			versionSubtitle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
		])

		// Initialize the tweak name label
		let tweakTitle: UILabel = UILabel()
		tweakTitle.text = tweakName
		tweakTitle.font = .systemFont(ofSize: 30.0)
		tweakTitle.textAlignment = .center
		tweakTitle.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(tweakTitle)

		// Position the tweak name label
		NSLayoutConstraint.activate([
			tweakTitle.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
			tweakTitle.bottomAnchor.constraint(equalTo: versionSubtitle.topAnchor),
			tweakTitle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
		])

		// Get the high quality icon of the tweak
		guard let image = UIImage(named: "bigicon.png", in: Bundle(for: BannerCell.self), compatibleWith: nil) else { return }

		// Initialize the image
		let tweakIconImageView: UIImageView = UIImageView(image: image)
		tweakIconImageView.layer.masksToBounds = true
		tweakIconImageView.layer.cornerRadius = 45.0
		tweakIconImageView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(tweakIconImageView)

		// Position the image
		NSLayoutConstraint.activate([
			tweakIconImageView.widthAnchor.constraint(equalToConstant: 90),
			tweakIconImageView.heightAnchor.constraint(equalToConstant: 90),
			tweakIconImageView.bottomAnchor.constraint(equalTo: tweakTitle.topAnchor, constant: -10),
			tweakIconImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
		])
	}
}