<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [ソースコード](#ソースコード)
- [実行環境](#実行環境)
- [(1) cpp](#1-cpp)
    - [出力結果より一部抜粋](#出力結果より一部抜粋)
    - [printf を protoptype ではなく #include <stdio.h> で定義した時はどうなるか。](#printf-を-protoptype-ではなく-include-stdioh-で定義した時はどうなるか)
- [(2) アセンブラ](#2-アセンブラ)
    - [ワーニング](#ワーニング)
    - [出力結果と考察](#出力結果と考察)
- [(3) LLVM byte code](#3-llvm-byte-code)
    - [出力結果](#出力結果)

<!-- markdown-toc end -->

# ソースコード

```
    extern int printf(char *,...);
    #define TYPE int
    TYPE f(TYPE a, TYPE b) {
        return a + b;
    }
    int main() 
    {
        TYPE a = 1;
        TYPE b = 2;
        printf("%x = %x + %x \n",f(a,b),a,b);
        return 0;
    }
```

# 実行環境
clang --version
Apple LLVM version 8.0.0 (clang-800.0.42.1)
Target: x86_64-apple-darwin16.7.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

# (1) cpp

   clang -E

での出力を調べる。
変換されている部分はどこか。 printf を protoptype ではなく #include <stdio.h> で定義した時はどうなるか。



```
# 1 "ex1.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 330 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "ex1.c" 2
extern int printf(char *,...);

int f(int a, int b) {
return a + b;
}
int main()
{
int a = 1;
int b = 2;
printf("%x = %x + %x \n",f(a,b),a,b);
return 0;
}
```
## 出力結果より一部抜粋

TYPEがintへ変換されている

```ex1_alt.log
%clang -E ex1.c 
# 1 "ex1.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 330 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "ex1.c" 2
extern int printf(char *,...);

int f(int a, int b) {
return a + b;
}
int main()
{
int a = 1;
int b = 2;
printf("%x = %x + %x \n",f(a,b),a,b);
return 0;
}
```


## printf を protoptype ではなく #include <stdio.h> で定義した時はどうなるか。
stdio.hを呼び出している．
型を推測して，intであると判断している．

```ex1.1.log
# 1 "ex1.1.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 330 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "ex1.1.c" 2
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/stdio.h" 1 3 4
# 64 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/stdio.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/sys/cdefs.h" 1 3 4
# 587 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/sys/cdefs.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/sys/_symbol_aliasing.h" 1 3 4
# 588 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/sys/cdefs.h" 2 3 4
# 653 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/sys/cdefs.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/sys/_posix_availability.h" 1 3 4
# 654 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/sys/cdefs.h" 2 3 4
# 65 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/stdio.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/Availability.h" 1 3 4
# 184 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/Availability.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/AvailabilityInternal.h" 1 3 4
# 185 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/Availability.h" 2 3 4
# 66 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/stdio.h" 2 3 4



(中略)

typedef unsigned char __uint8_t;
typedef short __int16_t;
typedef unsigned short __uint16_t;
typedef int __int32_t;
typedef unsigned int __uint32_t;
typedef long long __int64_t;
typedef unsigned long long __uint64_t;

typedef long __darwin_intptr_t;
typedef unsigned int __darwin_natural_t;
# 70 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/i386/_types.h" 3 4
typedef int __darwin_ct_rune_t;




(中略)



extern int __vsnprintf_chk (char * restrict, size_t, int, size_t,
       const char * restrict, va_list);
# 499 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/stdio.h" 2 3 4
# 2 "ex1.1.c" 2


int f(int a, int b) {
return a + b;
}
int main()
{
int a = 1;
int b = 2;
printf("%x = %x + %x \n",f(a,b),a,b);
return 0;
}

```

# (2) アセンブラ

   clang -S  -O0

で出力されるアセンブラについて調べる。
   clang -S  -O

についても調べる。
関数f はどうなっているか。

## ワーニング
```
/Users/e155755/Desktop/コンパイラ構成論 %
clang -S -O0 ex1.c
ex1.c:1:12: warning: incompatible redeclaration of library function 'printf' [-Wincompatible-library-redeclaration]
extern int printf(char *,...);
           ^
ex1.c:1:12: note: 'printf' is a builtin with type 'int (const char *, ...)'
1 warning generated.

```

## 出力結果と考察
関数fは，加算を行うアセンブリに変換されている．
-Sは最適化ステージのコードを生成するコマンド．アセンブリとしても読める．
-O0は，最適化しない引数であるから，特別構文が変化していない．


/Users/e155755/Desktop/コンパイラ構成論 %
clang -S -O0 ex1.c

```ex1.s
	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.globl	_f
	.align	4, 0x90
_f:                                     ## @f
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %esi
	addl	-8(%rbp), %esi
	movl	%esi, %eax
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp3:
	.cfi_def_cfa_offset 16
Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp5:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$1, -8(%rbp)
	movl	$2, -12(%rbp)
	movl	-8(%rbp), %edi
	movl	-12(%rbp), %esi
	callq	_f
	leaq	L_.str(%rip), %rdi
	movl	-8(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	%eax, %esi
	movb	$0, %al
	callq	_printf
	xorl	%ecx, %ecx
	movl	%eax, -16(%rbp)         ## 4-byte Spill
	movl	%ecx, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%x = %x + %x \n"


.subsections_via_symbols
```

# (3) LLVM byte code

   clang  -emit-llvm -S 

LLVM バイトコードの出力が得られることを確認せよ。
アセンブラとの対応を示せ。

## 出力結果
```
; ModuleID = 'ex1.c'
source_filename = "ex1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

@.str = private unnamed_addr constant [15 x i8] c"%x = %x + %x \0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @f(i32, i32) #0 {
  %3 = alloca i32, align 4                      ;alloca - 自動的に解放されるメモリーを割り当てる
  %4 = alloca i32, align 4                      
  store i32 %0, i32* %3, align 4                ;store　アドレスで指定されたメモリに入れる
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4　　　　　　　　 ;load メモリを読み込みレジスタに入れる
  %6 = load i32, i32* %4, align 4
  %7 = add nsw i32 %5, %6　　　　　　　　　　　　　 ;add 加算
  ret i32 %7
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 1, i32* %2, align 4
  store i32 2, i32* %3, align 4
  %4 = load i32, i32* %2, align 4
  %5 = load i32, i32* %3, align 4
  %6 = call i32 @f(i32 %4, i32 %5)
  %7 = load i32, i32* %2, align 4
  %8 = load i32, i32* %3, align 4
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i32 0, i32 0), i32 %6, i32 %7, i32 %8) ;call 命令による関数の呼び出し
  ret i32 0
}　　　　　　　　　　　　　　　　　　　　　　　　　　　;ret 呼び出し元に戻る

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 8.0.0 (clang-800.0.42.1)"}

```

