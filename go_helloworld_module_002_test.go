// go_helloworld_module_002_test.go
package showme

import (
	"testing"
)

func TestHello(t *testing.T) {
	result := Hello002()
	expected := "Hello, world!"
	if result != expected {
		t.Errorf("result %q expected %q", result, expected)
	}
}
