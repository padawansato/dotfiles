<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [ex3.1](#ex31)
    - [http://www.ie.u-ryukyu.ac.jp/%7Ekono/lecture/compiler/ex/005](#httpwwwieu-ryukyuacjp7ekonolecturecompilerex005)

<!-- markdown-toc end -->
# ex3.1
## url
http://www.ie.u-ryukyu.ac.jp/%7Ekono/lecture/compiler/ex/005

intel64はlittle-endianであり、メモリにはメモリのアドレスが小さい方に、 数値の小さい桁から格納される。また、%raxレジスタは、高い方の桁が8bit %ahレジスタ、低い方の桁が8bit レジスタ%alとなっている。32bit の int %eaxに入る。以下の数値は16進表記とする。

## cpu の endian を x/20x と x/20b を使って確認せよ。

```
clang -S ex3.1.c
clang ex3.1.s
/Users/e155755/Desktop/コンパイラ構成論 %
lldb a.out
(lldb) target create "a.out"
Current executable set to 'a.out' (x86_64).
(lldb) b test
Breakpoint 1: where = a.out`test, address = 0x0000000100000f20
(lldb) run
Process 82623 launched: '/Users/e155755/Desktop/コンパイラ構成論/a.out' (x86_64)
Process 82623 stopped
* thread #1: tid = 0x2d73ccd, 0x0000000100000f20 a.out`test, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000100000f20 a.out`test
a.out`test:
->  0x100000f20 <+0>: pushq  %rbp
    0x100000f21 <+1>: movq   %rsp, %rbp
    0x100000f24 <+4>: movq   %rdi, -0x8(%rbp)
    0x100000f28 <+8>: movq   %rsi, -0x10(%rbp)
(lldb) x/20x &a
0x100001018: 0x04030201 0x08070605 0x00001255 0x00000000
0x100001028: 0x00000000 0x00000000 0x00000000 0x00000000
0x100001038: 0x00000000 0x00000000 0x00000000 0x00000000
0x100001048: 0x00000000 0x00000000 0x00000000 0x00000000
0x100001058: 0x00000000 0x00000000 0x00000000 0x00000000
(lldb) x/20b &a
0x100001018: 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08
0x100001020: 0x55 0x12 0x00 0x00 0x00 0x00 0x00 0x00
0x100001028: 0x00 0x00 0x00 0x00
```
## movq (%rdi),%raxは、a[0] のアドレスの指す先をlongとして%raxレジスタに格納する。この命令を実行した時、 %raxレジスタの値はいくつになるかを16進で確認せよ。 %ahレジスタは? %alレジスタは? %eax レジスタは?
