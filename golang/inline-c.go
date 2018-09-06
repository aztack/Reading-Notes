package main

// const char* filename(void) {
//   static const char* s = "[" __FILE__ "]";
//   return s;
// }
import "C"

import (
	"fmt"
)

var filename = C.GoString(C.filename())

func __FILE__() string {
	return filename
}

func main() {
	fmt.Printf("%s\n", __FILE__())
}
