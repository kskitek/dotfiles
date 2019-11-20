package main

import (
	"encoding/base64"
	"encoding/hex"
	"fmt"
	"os"
	"strings"
)

func main() {
	fmt.Println(GuidToShort(os.Args[1]))
}

func GuidToShort(guid string) string {
	str := strings.Replace(guid, "-", "", -1)
	bytes, _ := hex.DecodeString(str)
	str = base64.StdEncoding.EncodeToString(bytes)
	str = strings.Replace(str, "/", "_", -1)
	str = strings.Replace(str, "+", "-", -1)
	return str[:22]
}
