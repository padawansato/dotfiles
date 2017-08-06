<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [リスト，集合演算](#リスト集合演算)
- [引用元 https://uid0130.blogspot.jp/2014/07/haskell.html](#引用元-httpsuid0130blogspotjp201407haskellhtml)
- [Excercise 1.1](#excercise-11)
- [](#)
    - [-](#-)
- [Excercise 1.2](#excercise-12)
- [Excercise 1.3](#excercise-13)
- [論理式、節形式、Prolog](#論理式節形式prolog)
- [Excercise 2.1](#excercise-21)
- [Excercise 2.2](#excercise-22)
- [Excercise 2.3](#excercise-23)
- [Excercise 4.1](#excercise-41)
- [Excercise 4.3](#excercise-43)
- [Excercise 4.4](#excercise-44)
- [System T on Agda](#system-t-on-agda)
- [Excercise 6.1](#excercise-61)
- [Excercise 7.1](#excercise-71)
- [Excercise 9.1](#excercise-91)
- [ex1.1](#ex11)

<!-- markdown-toc end -->

# リスト，集合演算
# 引用元 https://uid0130.blogspot.jp/2014/07/haskell.html

Prelude> import Data.List
Prelude Data.List> union [155756,155757,155758,155759,155760,155761] [155755]
[155756,155757,155758,155759,155760,155761,155755]

# Excercise 1.1
x = 1, y = 2, z = 3 で、入力 w に対して (x * y) + z + w を計算する関数 xyzw を以下の四つの方法で定義せよ。

#1 ghci の interactive mode で let を用いて定義する

main :: IO ()
main = do
    let x = 1
        y = 2
        z = 3
	putStrLn "wに代入する値を入力して下さい．"
	w <- getLine
	xyzw x y z w = (x * y) + z + w 
	ans = (xyzw x y z w)
	putStrLn ans

## 解答
Prelude> let xyzw x y z w =  (x * y) + z + w 
Prelude> x = 1
Prelude> y = 2
Prelude> z = 3
Prelude> xyzw x y z 4
9

# 解答2
Prelude> let xyzw w = let x=1;y=2;z=3 in (x * y) + z + w
Prelude> xyzw 3
8


#2 let を使い ; を用いずにファイル中で定義する
Lib.hs
f xyzw = let x =  1
             y =  2
             z =  3
         in (x * y) + z + w

someFunc :: IO ()
someFunc =  let x = 1
                y = 2
                z = 3
                w <- getLine
                xyzw x y z w = (x * y) + z + w
                in xyzw x y x w



```
func w = let x = 1       -- 式
             y = 2           -- 定数
             z = 3
			 f w = (x * y) + z + w-- 関数
         in do f w       -- 関数本体

main = print(func 4)
-- 27
```
```
func xyzw = let x = 1
                y = 2
				z = 3
```

## 回答
```
func w = let x = 1       -- 式
             y = 2           -- 定数
             z = 3
             f w = (x * y) + z + w-- 関数
         in do f w       -- 関数本体

main = print(func 4)
-- 9
```


## 解答
xyzw w = let x = 1
             y = 2
             z = 3
         in (x * y) + z + w

*Main> xyzw 3
8



# 3 where を使ってファイル中で定義する
## 解答
xyzw w = let x = 1
             y = 2
             z = 3
         in (x * y) + z + w

*Main> xyzw 3
8


# 4関数xyzをxyzw中で where を使って定義し、xyz 1 2 3 という形で使用する

xyzw4 w = (xyz 1 2 3) + w
    where xyz x y z = (x * y) + z

*Main> xyzw4 3
8


#stack　による　プロジェクトの構築
/Users/e155755/Desktop/Software-engineering%　stack new project1
/Users/e155755/Desktop/Software-engineering/project1% cd project1/
/Users/e155755/Desktop/Software-engineering/project1% stack build
/Users/e155755/Desktop/Software-engineering/project1% stack exec project1-exe

#参考になったサイト
https://wiki.haskell.org/10%E5%88%86%E3%81%A7%E5%AD%A6%E3%81%B6Haskell

#「ふつうのHaskellプログラミング」を読んで
### 遅延評価が他と違う


# Excercise 1.2
Haskell を使って、

    f : a -> b
    g : b -> c

の二つの関数を受けとって、その合成
    comp f g :  a -> b

を返す関数を作成せよ。
これが、+ と * 、文字列の結合に使えることを確かめよ。

# Excercise 1.3

http://ie.u-ryukyu.ac.jp/hg/teacher/index.cgi/home/hg/teacher/kono/software/BadWifiTest/

を Refactoring したい。

このソースコードあるいは、自分で用意した例題を使って、Refactoring の結果を hg pull request の形で提出せよ。

＊　ここに出てきた Class の主要なものを UML の Class 図で表せ

問題は複数ある Thread の扱いである。 これを複数の class に分解したい。

＊　可能な分割を UML のClass図で示せ

また、

＊　一部の Thread 動作をシーケンス図で表してみよ

InteliJ を使って実際に変更を実行し、pull request の形で提出せよ。


# 論理式、節形式、Prolog
孫 (grandchild) や従兄弟を表す一階述語論理の式を講義の文法に沿って表せ。

それを節形式に変換せよ。

さらに、シーケント代数の構文に合わせよ。

bortherの例にならって、Proplog で実装し、SWI-Prolog で実行してみよ。

# Excercise 2.1
1

ghci の interactive mode で let を用いて定義する
2

let を使い ; を用いずにファイル中で定義する
3

where を使ってファイル中で定義する
4

関数xyzをxyzw中で where を使って定義し、xyz 1 2 3 という形で使用する

# Excercise 2.2
引数4つの関数で、引数1を返す関数x1、引数2を返す関数x2、引数3を返す関数x3、引数4を返す関数x4を返す関数を定義する。

1

引数4つの関数パターンを用いる方法で記述せよ
2

λ式を使って定義せよ
3

x2 を用いて、λ式を使わずに x3を記述し、x3 を用いて x4 を記述せよ
4

x4 を用いて x1 、x2、x3 を記述せよ
5

x1,x2,x3,x4の型を示し、すべての実装で同じ型になることを確認せよ

# Excercise 2.3
以下の型を返す Haskell の関数を作成よ

   f0 : t -> t
   f1 : t -> (t1 -> t) -> t
   f2 : (t2 -> t1) -> (t1 -> t) -> t
   f3 : t -> t -> t
   f4 : ( t -> t ) -> t
   
# Excercise 4.1 
Agda での命題論理式の証明

Menu
以下の論理式の証明図に対応する Lambda 式を Agda で作れ。

   (1)  A -> A
   (2)  A -> (B -> A)
   (3)  (A ∧ (A -> B)) -> B
   (4)  B -> (B ∧ (A -> B))

作成した Lambda 式の型が、上の式に一致するはずである。
∧ は以下の定義を使ってみよう。

    record ^ (A B : Set) : Set where
       field
          and1 : A
          and2 : B
    data _^d_ ( A B : Set ) : Set where
      and : A -> B -> A ^d B

ヒント

(A ∧ B ) -> A は、\a -> _∧_.and1 a で証明できるが、

   (3)  (A ∧ (A -> B)) -> B

は、かなり難しい。
_∧_.and1 a と _∧_.and2 b をいじって、直接構成してもなんとかできるはずだが、

   lemma31  (A ∧ (A -> B)) -> (A -> B)
   lemma32  (A ∧ (A -> B)) ->  A
   lemma33  A -> ( A -> B ) -> B

の三つに分解すると簡単になる。(3-1) は (A ∧ B) -> B と同じ。この三つの lemma を組み合わせて証明を作ると良い。
Shinji KONO / Tue Jul 16 17:46:46 2013

# Excercise 4.3
ない

# Excercise 4.4
問題4.4

加算の反射率の証明を完成せよ。
    add-sym : (x y : Nat) → ( x + y ) == ( y + x )
    add-sym zero y = trans {!!} {!!}
    add-sym (suc x) y = {!!}

# System T on Agda
ゲーデルの System T を Agda 上に作成してみよう。


http://www.cr.ie.u-ryukyu.ac.jp/hg/Members/kono/Proof/category/file/75112154faf0/system-t.agda

# Excercise 6.1
Monad と自然変換

Menu
Haskell にある Monad で、

    η
    μ

の定義を Haskell あるいは、擬似的なコードで表し、それが自然変換であること、さらに、Monad の条件
   μ○Tη = 1_T = μ○ηT
   μ○μT  = μ○Tμ

を満たしていることを調べよ。
それらの条件が Monad に提供している性質について考察せよ。

# Excercise 7.1
Monad の組み合わせ

Menu
List Monad

List をメタデータとして持つ Monad を例に使ってきた。
この Monad を

    Haskell で記述 (既に記述されている)
    Java で記述
    Agda で記述

せよ。( C++ を使っても良い。C では記述することはできない。Ruby, Python では可能か? )
Agda は以下を参考せよ。

list-level.agda list-monad.agda

T が Functor であることの確認

それぞれの実装について、
Monad のTに相当するものがFunctor であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

ηが自然変換であることの確認

それぞれの実装について、
Monad のηに相当するものが自然変換 であることを確認する可換図を書き、その論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

μが自然変換であることの確認

それぞれの実装について、
Monad のηに相当するものが自然変換 であることを確認する可換図を書き、その論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

TT が Functor であることの確認

それぞれの実装について、
Monad のTTに相当するものが自然変換 であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

ηT が Functor であることの確認

それぞれの実装について、
Monad のTTに相当するものが自然変換 であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

Tη が Functor であることの確認

それぞれの実装について、
Monad のTTに相当するものが自然変換 であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

μT が Functor であることの確認

それぞれの実装について、
Monad のTTに相当するものが自然変換 であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

Tμ が Functor であることの確認

それぞれの実装について、
Monad のTTに相当するものが自然変換 であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。

Agda では可能ならば証明を示せ。

Monad 則1

それぞれの実装について、
   μ○Tη = 1_T = μ○ηT

であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。
Agda では可能ならば証明を示せ。

Monad 則2

それぞれの実装について、
   μ○μT  = μ○Tμ

であることを確認する論理式を、それぞれのプログラミング言語で記述せよ。
Agda では可能ならば証明を示せ。

組み合わせ

List Monad を他のMonad と組み合わせ可能にし ( Haskell では既に定義されている )
Maybe Monad あるいは、その他のMonadの組み合わせについて、Monad 則が成立していることを確認せよ。


# Excercise 9.1
記述問題

Menu
関数型言語の理論の以下の用語のどれかについて、デザインパターンなどのソフトウェア工学に技術との関連について、考察せよ。400-1000文字。

    参照透過性
    遅延評価
    モナド
    関手
    自然変換
    カーリーハワード対応
    
# ex1.1
```
let f x y z w = (x * y) + z + w
f 1 2 3 4
```
