package main

import (
	"fmt"
	"sync/atomic"
	"unsafe"
)

type SomeStruct struct {
	Value int
}

func main() {
	var ptr unsafe.Pointer

	// 初始结构体
	initial := &SomeStruct{Value: 42}
	atomic.StorePointer(&ptr, unsafe.Pointer(initial))

	// 读取指针
	read := (*int)(atomic.LoadPointer(&ptr))
	fmt.Println("Initial value:", read)

	// 创建新的结构体并尝试原子交换
	updated := &SomeStruct{Value: 100}
	if swapped := atomic.CompareAndSwapPointer(&ptr, unsafe.Pointer(initial), unsafe.Pointer(updated)); swapped {
		fmt.Println("Pointer swapped")
	} else {
		fmt.Println("Swap failed")
	}

	//// 检查更新后的值
	//read = (*SomeStruct)(atomic.LoadPointer(&ptr))
	//fmt.Println("Updated value:", read.Value)
}
