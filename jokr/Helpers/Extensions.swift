// Array Pretty Print
extension Array {
	func prettyPrint(initiator: String = "[",
	                 separator: String = ", ",
	                 terminator: String = "]") {
		let count = self.count
		guard let lastElement = self.last else {
			print(initiator + terminator)
			return
		}
		guard count > 1 else {
			print(initiator + "\(self[0])" + terminator)
			return
		}

		for element in self.dropLast() {
			print("\(element)" + separator, terminator: "")
		}

		print("\(lastElement)" + terminator)
	}

	func prettyPrintInLines() {
		self.prettyPrint(initiator: "", separator: "\n", terminator: "")
	}
}

// Array Shift
extension MutableCollection where Self: RandomAccessCollection {
	mutating func shift() {
		guard let first = self.first,
			count > 1 else { return }

		let lastValidIndex = index(before: endIndex)

		var i = startIndex
		while i != lastValidIndex {
			let next = index(after: i)
			self[i] = self[next]
			i = next
		}

		self[lastValidIndex] = first
	}

	func shifted() -> Self {
		var copy = self
		copy.shift()
		return copy
	}
}

// Array Copy
extension Collection {
	func arrayCopy() -> [Iterator.Element] {
		return self.map { $0 }
	}
}

// String Strip NSLog data
extension String {
	// TODO: Consider using new Swift 4 string-as-sequence APIs.
	func strippingNSLogData() -> String {
		let lines = self.components(separatedBy: "\n")
		let contents = lines.map { (string: String) -> String in
			var copy = string
			guard let closeBracketRange = copy.range(of: "]") else { return "" }
			let nslogDataEnd = copy.index(after: closeBracketRange.upperBound)
			copy.removeSubrange(copy.startIndex..<nslogDataEnd)
			return copy
		}
		return contents.joined(separator: "\n")
	}
}
