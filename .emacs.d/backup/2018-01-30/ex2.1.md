i386, emt64
# ex2.1
問題 2.1

以下のprogram check_endian.c がある。
    int check = 0x12345678;
    main()
    {
	char i, *ptr;
	
	ptr = (char *)&check; 
	i = ptr[1];
	return i;
    }

このprogramをcompileしたassemblerを、i386, emt64 のCPUで表示させて見よ。また、gdb で i にどのような値が入るかを確認せよ。そのCPUは、Little-Endian か Big-Endian かを答えよ。また、 trace の結果を、確認せよ。
Endian の変換はどのような時に必要になるか。どのようにすれば実現できるか?

Unix には、Builtin のEndianの変換関数がある。それを探し出せ。また、その実装がどうなっているかを調べよ。(ヒント: man -kを使う)





## emt64とは
Intel 80386（またはi386）はインテルの32ビットマイクロプロセッサ(CPU)である。1985 年10月に発表され、x86アーキテクチャを32ビットに拡張し、レジスタを強化した
インテルは自社アーキテクチャを「EM64T（Intel Extended Memory 64 Technology）」と呼び、AMD（Advanced Micro Devices, Inc.）は「AMD64 ISA」と呼んでいる

## 実行結果
```

```
