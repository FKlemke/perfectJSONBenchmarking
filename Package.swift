

import PackageDescription

// Note that the following Swift Package Manager dependancy inclusion will also import other required modules.
let package = Package(
    name: "perfectBenchmarking",
    targets: [],
    dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2, minor: 0)
	]
)
