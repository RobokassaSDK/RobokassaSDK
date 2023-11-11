// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "RoboKassaSDK",
	platforms: [
		.iOS(.v13),
	],
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "RoboKassaSDK",
			targets: [
				"RoboKassaSDK",
				"Delegates",
				"Extensions",
				"Models",
				"RoboKassaWeb",
				"Architecture"
			]),
	],
	dependencies: [
		.package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
		.package(url: "https://github.com/FirestoreSDK/FirestoreSDK", branch: "master"),
	],
	targets: [
		.target(
			name: "RoboKassaSDK",
			dependencies: [
				.product(name: "SnapKit", package: "SnapKit"),
				.product(name: "FirestoreSDK", package: "FirestoreSDK"),
    			.target(name: "Delegates"),
				.target(name: "Extensions"),
				.target(name: "Models"),
				.target(name: "RoboKassaWeb"),
				.target(name: "Architecture"),
			]
		),
		.target(
			name: "Delegates",
			dependencies: [
				.target(name: "Extensions"),
				.target(name: "Architecture"),
				]
		),
		.target(
			name: "Extensions",
			dependencies: [
				.target(name: "Models"),
				]
		),
		.target(
			name: "Models"
		),
		.target(
			name: "Architecture"
		),
		.target(
			name: "RoboKassaWeb",
			dependencies: [
				.target(name: "Delegates"),
				]
		),
	]
)
