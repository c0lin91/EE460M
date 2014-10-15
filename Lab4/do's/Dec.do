force CLK 0 0 ns, 1 5 ns -repeat 10 ns
force LOAD 1'b1 0 ns
force CLR 1'b1 0 ns
force ENABLE 1'b1 0 ns
force D1 4'b0000 0 ns
force D2 4'b0000 0 ns
force D3 4'b0000 0 ns
force D4 4'b1001 0 ns

force LOAD 1'b0 8 ns
run 200 ns
