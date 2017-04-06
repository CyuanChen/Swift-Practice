
/// Insert Sort : 
/// best O(n), worst O(n^2) avg O(n^2)


let list1 = [70, 2, 5, 20, -7, -3, 0, 2, 30, 99, -4, 71, 5]
let list2 = ["e", "b", "x", "h", "n", "b", "w", "c", "o", "g", "z", "u", "z"]
let list3 = ["A"]


func insertionSort<T: Comparable>(_ array:[T], _ compare: (T, T) -> Bool) -> [T] {
	var tempArray = array 
	for position in 1..< tempArray.count {
		var pointer = position
		while pointer > 0 && compare(tempArray[pointer], tempArray[poinster - 1]) {
			swap(&tempArray[pointer], &tempArray[pointer - 1])
			pointer -= 1
		}
	}
	return tempArray
}

let insertionSorted1 = insertionSort(list1, <)// small to big
let insertinoSorted2 = insertionSort(list2, >)// big to small



/// Shell Sort(希爾排序): 以一定的跨度來比較，速度比Insertion Sort 快

func shellSort<T: Comparable>(_ array:[T], compare:(T, T) -> Bool) -> [T] where T: Comparable {
	var tempArray = array
	var gap = array.count / 2
	while gap > 0 {
		for position in 0..< tempArray.count {
			// make sure position + gap smaller 
			guard position + gap < tempArray.count else {break} // jump out for loop
			// based on compare is > or < 
			if compare(tempArray[position], tempArray[position + gap]) { 
				swap(&tempArray[position], &tempArray[position + gap])  
			}
			guard gap == 1 && position > 0 else {continue} // to next for loop
			if tempArray[position - 1] > tempArray[position] {
				swap(&tempArray[position - 1], &tempArray[position])
			}
		}
		gap /= 2
	}
	return tempArray	
}


/// Selection Sort : 從未排序的array找到最小(大)的放到第一個

func selectionSort<T: Comparable>(_array:[T], _ compare:(T,T) -> Bool) -> [T] {
	guard array.count > 1 else {
		return array
	}

	var tempArray = array

	for position in  0..< tempArray.count {
		var pointer = position + 1
		var targetPosition = position

		while pointer < tempArray.count {
			if compare(tempArray[targetPosition], tempArray[pointer]) {
				targetPosition = pointer
			}
			pointer += 1
		}

		if targetPosition != position {
			swap(&tempArray[position], &tempArray[targetPosition])
		}
	}
	return tempArray
}

let selectionSorted1 =selectionSort(list1, >)
let selectionSorted2 =selectionSort(list2, >)














































