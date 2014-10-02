force CLK 0 0 ns, 1 5 ns -repeat 10 ns
force Clr 1 0 ns
force Up 0 0 ns
force D1 4'b0111 0 ns
force D2 4'b1001 0 ns
force Load 1 0 ns
force Enable 1 0 ns

force Load 0 8 ns
force Up 1 8 ns
force Up 0 58 ns
force Enable 0 58 ns
force Enable 1 78 ns
force Enable 0 118 ns
force Clr 0 125 ns
run 140 ns