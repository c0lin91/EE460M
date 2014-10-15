force CLK 0 0 ns, 1 5 ns -repeat 10 ns
force CLR 1 0 ns
force D1 4'b0111 0 ns
force D2 4'b1001 0 ns
force LOAD 1 0 ns
force ENABLE 1 0 ns

force LOAD 0 8 ns
force ENABLE 0 58 ns
force ENABLE 1 78 ns
force ENABLE 0 118 ns
force CLR 0 118 ns
run 200 ns