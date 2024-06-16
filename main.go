package main

// import (
//
//	"fmt"
//	"sync/atomic"
//	"unsafe"
//
// )
//
//	type SomeStruct struct {
//		Value int
//	}
//
//	func main() {
//		var ptr unsafe.Pointer
//
//		// 初始结构体
//		initial := &SomeStruct{Value: 42}
//		atomic.StorePointer(&ptr, unsafe.Pointer(initial))
//
//		// 读取指针
//		read := (*int)(atomic.LoadPointer(&ptr))
//		fmt.Println("Initial value:", read)
//
//		// 创建新的结构体并尝试原子交换
//		updated := &SomeStruct{Value: 100}
//		if swapped := atomic.CompareAndSwapPointer(&ptr, unsafe.Pointer(initial), unsafe.Pointer(updated)); swapped {
//			fmt.Println("Pointer swapped")
//		} else {
//			fmt.Println("Swap failed")
//		}
//
//		//// 检查更新后的值
//		//read = (*SomeStruct)(atomic.LoadPointer(&ptr))
//		//fmt.Println("Updated value:", read.Value)
//	}

// 访问etcd
//
//	func main() {
//		// 创建一个客户端配置
//		cli, err := clientv3.New(clientv3.Config{
//			Endpoints:   []string{"localhost:2379"}, // etcd 集群的地址
//			DialTimeout: 5 * time.Second,
//		})
//		if err != nil {
//			log.Fatal(err)
//		}
//		defer cli.Close()
//
//		// 使用上下文进行超时控制
//		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
//		defer cancel()
//
//		// 示例：放置一个键值对
//		_, err = cli.Put(ctx, "sample_key", "sample_value")
//		if err != nil {
//			log.Fatal(err)
//		}
//
//		// 示例：获取一个键值对
//		resp, err := cli.Get(ctx, "sample_key")
//		if err != nil {
//			log.Fatal(err)
//		}
//		for _, ev := range resp.Kvs {
//			fmt.Printf("%s : %s\n", ev.Key, ev.Value)
//		}
//	}
