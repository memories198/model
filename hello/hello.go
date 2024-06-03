package hello

func Sort(nums []int) {
	n := len(nums)
	for i := 0; i < n; i++ {
		for j := 0; j < n-1-i; j++ {
			if nums[j] > nums[j+1] {
				nums[j], nums[j+1] = nums[j+1], nums[j]
			}
		}
	}
}

func QuickSort1(arr []int) []int {
	if len(arr) <= 1 {
		return arr
	}

	pivot := arr[0]
	var left, right []int

	for _, v := range arr[1:] {
		if v <= pivot {
			left = append(left, v)
		} else {
			right = append(right, v)
		}
	}

	left = QuickSort1(left)
	right = QuickSort1(right)

	return append(append(left, pivot), right...)
}

func QuickSort2(nums []int, left, right int) {
	if left < right {
		mid := partition(nums, left, right)
		QuickSort2(nums, left, mid-1)
		QuickSort2(nums, mid+1, right)
	}
}

func partition(nums []int, left, right int) int {
	mid := nums[right]
	i := left
	for j := left; j < right; j++ {
		if nums[j] < mid {
			nums[i], nums[j] = nums[j], nums[i]
			i++
		}
	}
	nums[i], nums[right] = nums[right], nums[i]
	return i
}
