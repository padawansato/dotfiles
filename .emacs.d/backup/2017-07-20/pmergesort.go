package main

import (
		//"fmt"
		"log"
		"sync"
    "time"
    "math/rand"
)


func merge(left, right []int) (ret []int) {
    ret = []int{}
    for len(left) > 0 && len(right) > 0 {
        var x int
        // ソート済みのふたつのスライスからより小さいものを選んで追加していく (これがソート処理)
        if right[0] > left[0] {
            x, left = left[0], left[1:]
        } else {
            x, right = right[0], right[1:]
        }
        ret = append(ret, x)
    }
    // 片方のスライスから追加する要素がなくなったら残りは単純に連結できる (各スライスは既にソートされているため)
    ret = append(ret, left...)
    ret = append(ret, right...)
    return
}

func sort(left, right []int) (ret []int) {
    // ふたつのスライスをそれぞれ再帰的にソートする
		var wg sync.WaitGroup
		wg.Add(2)
		go func(){
    if len(left) > 1 {
        l, r := split(left)
        left = sort(l, r)
    }
		wg.Done()
	}()
	go func(){
    if len(right) > 1 {
        l, r := split(right)
        right = sort(l, r)
    }
		wg.Done()
	}()
	wg.Wait()

    // ソート済みのふたつのスライスをひとつにマージする
    ret = merge(left, right)
    return
}

func split(values []int) (left, right []int) {
    // スライスを真ん中でふたつに分割する
    left = values[:len(values) / 2]
    right = values[len(values) / 2:]
    return
}

func Sort(values []int) (ret []int) {
    left, right := split(values)
    ret = sort(left, right)
    return
}

func main() {
    // UNIX 時間をシードにして乱数生成器を用意する
    t := time.Now().Unix()
    s := rand.NewSource(t)
    r := rand.New(s)

    // ランダムな値の入った配列を作る
    N := 2000000
    values := make([]int, N)
    for i := 0; i < N; i++ {
        values[i] = r.Intn(N)
    }

		log.Print("Start")

    // ソートして結果を出力する
    Sort(values)
		// fmt.Println(sortedValues)
		log.Print("end")
	}
