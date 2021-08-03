.PHONY: run
run: build/lib.wasm tools/wasmtime/wasmtime
	./tools/wasmtime/wasmtime run ./build/lib.wasm --invoke add 100 200

.PHONY: clean
clean:
	rm -rf build temp tools

build/lib.wasm: tools/wasi-sdk/bin/clang++
	mkdir -p build
	./tools/wasi-sdk/bin/clang++ \
		-I ./include \
		--sysroot=./tools/wasi-sdk/share/wasi-sysroot \
		-nostartfiles \
		-fno-exceptions \
		-Wl,--export-all \
		-Wl,--no-entry \
		src/lib.cpp -o build/lib.wasm

tools/wasi-sdk/bin/clang++: temp/wasi-sdk.tar.gz 
	mkdir -p tools/wasi-sdk
	tar xvf temp/wasi-sdk.tar.gz -C tools/wasi-sdk --strip-components 1

tools/wasmtime/wasmtime: temp/wasmtime.tar.gz
	mkdir -p tools/wasmtime
	tar xvf temp/wasmtime.tar.gz -C tools/wasmtime --strip-components 1

temp/wasi-sdk.tar.gz: temp
	curl https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-12/wasi-sdk-12.0-macos.tar.gz -o temp/wasi-sdk.tar.gz -L

temp/wasmtime.tar.gz: temp
	curl https://github.com/bytecodealliance/wasmtime/releases/download/v0.28.0/wasmtime-v0.28.0-x86_64-macos.tar.xz -o temp/wasmtime.tar.gz -L

temp:
	mkdir -p temp

