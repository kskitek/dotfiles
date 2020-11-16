package main

import (
	"encoding/hex"
	"fmt"
  "os"
)

func main() {
	src := []byte(os.Args[1])
	encodedStr := hex.EncodeToString(src)
	fmt.Printf("00000000%s\n", encodedStr)

}
