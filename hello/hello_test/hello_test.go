package hello_test

import (
	"math/rand"
	"model/hello"
	"slices"
	"testing"
)

func Test_Sort(t *testing.T) {
	tests := []struct {
		name string
		args []int
		want []int
	}{
		{
			"test1",
			[]int{10, 9, 3, 4, 2, 1},
			[]int{1, 2, 3, 4, 9, 10},
		},
		{
			"test2",
			[]int{9, 8, 7, 6, 5},
			[]int{5, 6, 7, 8, 9},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			hello.Sort(tt.args)
			if !slices.Equal(tt.want, tt.args) {
				t.Errorf("got: %v\nwant: %v", tt.args, tt.want)
			}
		})
	}
}

func Test_QuickSort1(t *testing.T) {
	tests := []struct {
		name string
		args []int
		want []int
	}{
		{
			"test1",
			[]int{10, 9, 3, 4, 2, 1},
			[]int{1, 2, 3, 4, 9, 10},
		},
		{
			"test2",
			[]int{9, 8, 7, 6, 5},
			[]int{5, 6, 7, 8, 9},
		},
	}

	for _, tt := range tests {

		t.Run(tt.name, func(t *testing.T) {
			got := hello.QuickSort1(tt.args)
			if !slices.Equal(tt.want, got) {
				t.Errorf("got: %v\nwant: %v", got, tt.want)
			}
		})
	}

}
func Test_QuickSort(t *testing.T) {
	tests := []struct {
		name string
		args []int
		want []int
	}{
		{
			"test1",
			[]int{10, 9, 3, 4, 2, 1},
			[]int{1, 2, 3, 4, 9, 10},
		},
		{
			"test2",
			[]int{9, 8, 7, 6, 5},
			[]int{5, 6, 7, 8, 9},
		},
	}

	for _, tt := range tests {

		t.Run(tt.name, func(t *testing.T) {
			hello.QuickSort2(tt.args, 0, len(tt.args)-1)
			if !slices.Equal(tt.want, tt.args) {
				t.Errorf("got: %v\nwant: %v", tt.args, tt.want)
			}
		})
	}

}

var n = 1000
var nums = make([]int, n)

func init() {
	for i := 0; i < n; i++ {
		nums[i] = rand.Int()
	}
}

func Benchmark_QuickSort1(b *testing.B) {
	for i := 0; i < b.N; i++ {
		hello.QuickSort1(nums)
	}
}
func Benchmark_QuickSort2(b *testing.B) {
	for i := 0; i < b.N; i++ {
		hello.QuickSort2(nums, 0, n-1)
	}
}
func Benchmark_Sort(b *testing.B) {
	for i := 0; i < b.N; i++ {
		hello.Sort(nums)
	}
}
