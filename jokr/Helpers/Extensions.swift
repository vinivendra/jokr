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

protocol MutableRandomAccessCollection:
MutableCollection, RandomAccessCollection { }

extension MutableRandomAccessCollection {
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

extension Array: MutableRandomAccessCollection { }

// TODO: Add to all array equal tests
extension Collection {
	func arrayCopy() -> [Iterator.Element] {
		return self.map { $0 }
	}
}
