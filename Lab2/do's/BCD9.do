force CLK 0 0 ns, 1 5 ns -repeat 10 ns
force Clr 1 0 ns
force Up 0 0 ns
force D 4'b0110 0 ns
force Load 1 0 ns
force Enable 1 0 ns

force Load 0 8 ns
force Up 1 8 ns
force Up 0 48 ns
force Clr 0 62 ns
run 84 ns