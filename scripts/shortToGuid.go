package main

import (
	"encoding/base64"
	"encoding/hex"
	"fmt"
	"os"
	"strings"
)

func main() {
	fmt.Println(ShortToGuid(os.Args[1]))
}

func ShortToGuid(guid string) (string, error) {
	if len(guid) != 22 {
		return "", fmt.Errorf("Input is not short guid")
	}
	str := guid + "=="
	str = strings.Replace(str, "_", "/", -1)
	str = strings.Replace(str, "-", "+", -1)
	bytes, _ := base64.StdEncoding.DecodeString(str)
	str = hex.EncodeToString(bytes)
	out := make([]string, 5)
	out[0] = str[:8]
	out[1] = str[8:12]
	out[2] = str[12:16]
	out[3] = str[16:20]
	out[4] = str[20:]
	str = strings.Join(out, "-")
	return str, nil
}
