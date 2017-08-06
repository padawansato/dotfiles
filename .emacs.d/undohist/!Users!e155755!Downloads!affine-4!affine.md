
((digest . "50b17d0bf3d54984cd7a49ff6b6120f4") (undo-list nil (40 . 1273) nil ("
- [ソフトコンピューティング](#ソフトコンピューティング)
- [実験内容](#実験内容)
    - [実験．](#実験)
    - [CNNを用いないMNIST分類の実装](#cnnを用いないmnist分類の実装)
    - [データの確認](#データの確認)
    - [3層ニューラルネットワーク](#3層ニューラルネットワーク)
        - [Affineレイヤとは](#affineレイヤとは)
        - [CNNにおけるAffineレイヤ](#cnnにおけるaffineレイヤ)
        - [softmaxレイヤとは](#softmaxレイヤとは)
        - [ReLUレイヤとは](#reluレイヤとは)
    - [バッチ処理](#バッチ処理)
    - [考察](#考察)
    - [考察を踏まえた改善](#考察を踏まえた改善)
        - [Dropout関数](#dropout関数)
        - [最適化関数](#最適化関数)
            - [Adadelta](#adadelta)
            - [RMSprop](#rmsprop)
    - [改善の結果](#改善の結果)
    - [CNNによるMNIST分類の実装](#cnnによるmnist分類の実装)
        - [異なる点](#異なる点)
    - [CNNによる3層ニューラルネットワーク](#cnnによる3層ニューラルネットワーク)
        - [Convolutionレイヤ](#convolutionレイヤ)
            - [畳み込み演算](#畳み込み演算)
        - [Poolingレイヤ](#poolingレイヤ)
        - [Flatten関数](#flatten関数)
        - [実行結果](#実行結果)
        - [実行結果の比較](#実行結果の比較)
            - [CNNではない実装](#cnnではない実装)
            - [CNNによる実装](#cnnによる実装)
            - [正答率](#正答率)
            - [今後の課題](#今後の課題)

" . -40) ((marker) . -1005) ((marker) . -358) ((marker . 1245) . -912) ((marker . 1245) . -912) ((marker . 1179) . -1005) ((marker . 1179) . -1005) ((marker) . -1005) ((marker . 41) . -1) 1045 nil ("<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [ソフトコンピューティング](#ソフトコンピューティング)
- [実験内容](#実験内容)
    - [実験．](#実験)
        - [-](#-)
    - [CNNを用いないMNIST分類の実装](#cnnを用いないmnist分類の実装)
    - [データの確認](#データの確認)
    - [3層ニューラルネットワーク](#3層ニューラルネットワーク)
        - [Affineレイヤとは](#affineレイヤとは)
        - [CNNにおけるAffineレイヤ](#cnnにおけるaffineレイヤ)
        - [softmaxレイヤとは](#softmaxレイヤとは)
        - [ReLUレイヤとは](#reluレイヤとは)
    - [バッチ処理](#バッチ処理)
    - [考察](#考察)
    - [考察を踏まえた改善](#考察を踏まえた改善)
        - [Dropout関数](#dropout関数)
        - [最適化関数](#最適化関数)
            - [Adadelta](#adadelta)
            - [RMSprop](#rmsprop)
    - [改善の結果](#改善の結果)
    - [CNNによるMNIST分類の実装](#cnnによるmnist分類の実装)
        - [異なる点](#異なる点)
    - [CNNによる3層ニューラルネットワーク](#cnnによる3層ニューラルネットワーク)
        - [Convolutionレイヤ](#convolutionレイヤ)
            - [畳み込み演算](#畳み込み演算)
        - [Poolingレイヤ](#poolingレイヤ)
        - [Flatten関数](#flatten関数)
        - [実行結果](#実行結果)
        - [実行結果の比較](#実行結果の比較)
            - [CNNではない実装](#cnnではない実装)
            - [CNNによる実装](#cnnによる実装)
            - [正答率](#正答率)
            - [今後の課題](#今後の課題)
            - [引用元](#引用元)
            - [本稿を参照したい場合](#本稿を参照したい場合)

<!-- markdown-toc end -->

" . 1) ((marker) . -1233) ((marker) . -1233) ((marker) . -539) ((marker . 1246) . -1233) ((marker . 1246) . -1233) ((marker . 1354) . -1206) ((marker . 1354) . -1206) ((marker . 1353) . -1205) ((marker . 1353) . -1205) ((marker . 1) . -95) ((marker) . -1233) ((marker . 41) . -1) ((marker . 1) . -95) ((marker . 2) . -96) ((marker . 2) . -1) 1234 nil (1 . 1233) (t 22911 10416 0 0) nil (1 . 18617) ("<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [ソフトコンピューティング](#ソフトコンピューティング)
- [実験内容](#実験内容)
    - [実験課題3番．](#実験課題3番)
    - [データの確認](#データの確認)
    - [3層ニューラルネットワーク](#3層ニューラルネットワーク)
        - [Affineレイヤとは](#affineレイヤとは)
        - [CNNにおけるAffineレイヤ](#cnnにおけるaffineレイヤ)
        - [softmaxレイヤとは](#softmaxレイヤとは)
        - [ReLUレイヤとは](#reluレイヤとは)
    - [add()でレイヤーを重ねる．](#addでレイヤーを重ねる)
    - [Affine->relu->Affine->relu->softmax の3層NNの線形スタック](#affine-relu-affine-relu-softmax-の3層nnの線形スタック)
    - [dropout()で過学習を抑制．](#dropoutで過学習を抑制)
    - [512はニューロンの数](#512はニューロンの数)
    - [activationで活性化関数をreluに指定．](#activationで活性化関数をreluに指定)
    - [最後の出力層にはsoftmaxを指定．](#最後の出力層にはsoftmaxを指定)
    - [訓練プロセスの設定](#訓練プロセスの設定)
    - [RMSprop()は学習係数を過去の勾配を徐々に忘れる，\"指数移動平均\"を使う．](#rmspropは学習係数を過去の勾配を徐々に忘れる指数移動平均を使う)
    - [バッチ処理](#バッチ処理)
    - [考察](#考察)
    - [考察を踏まえた改善](#考察を踏まえた改善)
        - [Dropout関数](#dropout関数)
    - [改善の結果](#改善の結果)
    - [CNNによるMNIST分類の実装](#cnnによるmnist分類の実装)

<!-- markdown-toc end -->

# ソフトコンピューティング
 155755G 情報工学科３年次  佐藤匠


- [ソフトコンピューティング](#ソフトコンピューティング)
    - [実験内容](#実験内容)
        - [実験課題3番．](#実験課題3番)
        - [データの確認](#データの確認)
        - [3層ニューラルネットワーク](#3層ニューラルネットワーク)
            - [Affineレイヤとは](#affineレイヤとは)
            - [CNNにおけるAffineレイヤ](#cnnにおけるaffineレイヤ)
            - [softmaxレイヤとは](#softmaxレイヤとは)
            - [ReLUレイヤとは](#reluレイヤとは)
        - [バッチ処理](#バッチ処理)
        - [考察](#考察)
        - [考察を踏まえた改善](#考察を踏まえた改善)
            - [Dropout関数](#dropout関数)
        - [改善の結果](#改善の結果)

# 実験内容
## 実験課題3番．
 
 
 自身が興味のあるデータセットを用意して、CNNを用いた計算実験を行い、レポート報告する。レポート形式は自由。
 
 

本稿ではKeras用いて，手書き数字(以降MNIST)の画像を分類(以降MNIST分類)し，次に学習結果の向上の考察をする．


まずはじめに，畳み込みニューラルネットワーク(以降CNN)ではない実装の１つ，結合を全結合で行うレイヤ(以降Affineレイヤ)によるMNISTの実装を行う．

次に，CNNを用いた，MNIST分類を行う．

## データの確認
 MNISTのデータをニューラルネットワーク(以降NN)に入力したい．



```python
%matplotlib inline
import keras
from keras.datasets import mnist
import matplotlib.pyplot as plt

#Kerasの関数でデータの読み込み。データをシャッフルして学習データと訓練データに分割している.
(x_train, y_train), (x_test, y_test) = mnist.load_data()

#MNISTデータの表示
fig = plt.figure(figsize=(9, 9))
fig.subplots_adjust(left=0, right=1, bottom=0, top=0.5, hspace=0.05, wspace=0.05)
for i in range(81):
    ax = fig.add_subplot(9, 9, i + 1, xticks=[], yticks=[])
    ax.imshow(x_train[i].reshape((28, 28)), cmap='gray')
```


![png](output_3_0.png)


 60,000枚の28x28，10個の数字の白黒画像と10,000枚のテスト用画像データセット


```python
num_classes = 10 # 出力層(output layer)のニューロンは10個 分類したい数に対応している．
x_train = x_train.reshape(60000, 784) #  reshapeは28×28画素の画像を784×1のデータに変換している．
x_test = x_test.reshape(10000, 784)
# 各データを扱いにくいので、RGBの値(白なら255、黒なら0)を利用して0から1までの間に正規化.
x_train = x_train.astype('float32') 
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255

y_train = y_train.astype('int32')
y_test = y_test.astype('int32')
y_train = keras.utils.np_utils.to_categorical(y_train, num_classes)
y_test =  keras.utils.np_utils.to_categorical(y_test, num_classes)

print('x_train shape:', x_train.shape)
print(x_train.shape[0], 'train samples')
print(x_test.shape[0], 'test samples')
```

    60000 train samples
    10000 test samples



```python
#to_categorical()は，num_classの数の要素を持つ前からy_trainがonehotのリストを作る．
#0#[1,0,0,0,0,0,0,0,0,0]
#1#[0,1,0,0,0,0,0,0,0,0]
```

## 3層ニューラルネットワーク
　MNISTのデータを受け取り,学習する3層ニューラルネットワーク．


　Affine->relu->Affine->relu->softmax の順でデータを渡す，線形スタックである．


### Affineレイヤとは
　Affineレイヤは，ニューロン同士が全結合のニューラルネットワークレイヤを指す．
 
### CNNにおけるAffineレイヤ
　CNNはAffineレイヤに加え，畳み込みレイヤ(Convolution)とプーリングレイヤ(Pooling)を用いる．

### softmaxレイヤとは
　入力されたデータを足した値が1になるように出力する層．各要素の大小関係は変わらない．NNにおいて往々にして出力層はsoftmaxレイヤである．この特性から，a%で結果A,b%で結果B,c%で結果Cという確率的な答えが求められる場合がある．しかし，今回のようなクラス分類問題では，出力の一番大きいニューロンに相当するものみが選ばれるため，その役割は満たせない．
### ReLUレイヤとは
　活性化関数として使われる．回路におけるスイッチの様に機能する．


```python
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation
from keras.optimizers import RMSprop

## add()でレイヤーを重ねる．
## Affine->relu->Affine->relu->softmax の3層NNの線形スタック
## dropout()で過学習を抑制．
## 512はニューロンの数
## activationで活性化関数をreluに指定．
## 最後の出力層にはsoftmaxを指定．

model = Sequential()
model.add(Dense(512, activation='relu', input_shape=(784,))) ## 入力のshapeは(512,784,)になる．
model.add(Dropout(0.2))
model.add(Dense(512, activation='relu')) ## ２度目以降は入力のshapeをkerasが推定．
model.add(Dropout(0.2))
model.add(Dense(10, activation='softmax'))## softmaxは今回は分類問題なので，必要性は低い．

## 訓練プロセスの設定
## RMSprop()は学習係数を過去の勾配を徐々に忘れる，\"指数移動平均\"を使う．
model.compile(loss='categorical_crossentropy',
              optimizer=RMSprop(),
              metrics=['accuracy'])
```

## バッチ処理
　バッチ処理によって，実行時間を短縮することができる．
 imageのサイズ/バッチのサイズ ->1epochでの計算回数


```python
batch_size = 128
epochs = 20 ##学習の回数
##historyにfittingの課程を保存．
history = model.fit(x_train, y_train,
                    batch_size=batch_size, epochs=epochs,
                    verbose=1, validation_data=(x_test, y_test))
```

    Train on 60000 samples, validate on 10000 samples
    Epoch 1/20
    60000/60000 [==============================] - 15s - loss: 0.2501 - acc: 0.9226 - val_loss: 0.1096 - val_acc: 0.9650
    Epoch 2/20
    60000/60000 [==============================] - 13s - loss: 0.1025 - acc: 0.9682 - val_loss: 0.1021 - val_acc: 0.9685
    Epoch 3/20
    60000/60000 [==============================] - 14s - loss: 0.0776 - acc: 0.9764 - val_loss: 0.0755 - val_acc: 0.9778
    Epoch 4/20
    60000/60000 [==============================] - 13s - loss: 0.0615 - acc: 0.9818 - val_loss: 0.0894 - val_acc: 0.9746
    Epoch 5/20
    60000/60000 [==============================] - 13s - loss: 0.0506 - acc: 0.9846 - val_loss: 0.0784 - val_acc: 0.9794
    Epoch 6/20
    60000/60000 [==============================] - 13s - loss: 0.0451 - acc: 0.9872 - val_loss: 0.0778 - val_acc: 0.9806
    Epoch 7/20
    60000/60000 [==============================] - 13s - loss: 0.0398 - acc: 0.9886 - val_loss: 0.0697 - val_acc: 0.9831
    Epoch 8/20
    60000/60000 [==============================] - 13s - loss: 0.0366 - acc: 0.9893 - val_loss: 0.1008 - val_acc: 0.9812
    Epoch 9/20
    60000/60000 [==============================] - 13s - loss: 0.0322 - acc: 0.9907 - val_loss: 0.0854 - val_acc: 0.9831
    Epoch 10/20
    60000/60000 [==============================] - 13s - loss: 0.0284 - acc: 0.9918 - val_loss: 0.0904 - val_acc: 0.9817
    Epoch 11/20
    60000/60000 [==============================] - 13s - loss: 0.0268 - acc: 0.9918 - val_loss: 0.0958 - val_acc: 0.9820
    Epoch 12/20
    60000/60000 [==============================] - 13s - loss: 0.0262 - acc: 0.9930 - val_loss: 0.1001 - val_acc: 0.9797
    Epoch 13/20
    60000/60000 [==============================] - 12s - loss: 0.0238 - acc: 0.9930 - val_loss: 0.0951 - val_acc: 0.9834
    Epoch 14/20
    60000/60000 [==============================] - 12s - loss: 0.0228 - acc: 0.9937 - val_loss: 0.0975 - val_acc: 0.9847
    Epoch 15/20
    60000/60000 [==============================] - 14s - loss: 0.0214 - acc: 0.9942 - val_loss: 0.0984 - val_acc: 0.9831
    Epoch 16/20
    60000/60000 [==============================] - 13s - loss: 0.0191 - acc: 0.9946 - val_loss: 0.0994 - val_acc: 0.9842
    Epoch 17/20
    60000/60000 [==============================] - 13s - loss: 0.0192 - acc: 0.9948 - val_loss: 0.1141 - val_acc: 0.9834
    Epoch 18/20
    60000/60000 [==============================] - 13s - loss: 0.0191 - acc: 0.9948 - val_loss: 0.1025 - val_acc: 0.9846
    Epoch 19/20
    60000/60000 [==============================] - 13s - loss: 0.0182 - acc: 0.9950 - val_loss: 0.1054 - val_acc: 0.9834
    Epoch 20/20
    60000/60000 [==============================] - 13s - loss: 0.0171 - acc: 0.9958 - val_loss: 0.1104 - val_acc: 0.9834



```python
#正答率
plt.plot(history.history['acc'])
plt.plot(history.history['val_acc'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()
#loss
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()
```


![png](output_11_0.png)



![png](output_11_1.png)


## 考察
　上記出力結果のmodel lossが,学習が進むに連れて悪くなっていった．これは過学習をしかけていると考えられる．
## 考察を踏まえた改善
### Dropout関数
　過学習を防ぐ手法にDropoutがある．ランダムにニューロンを削除することにより，過学習を防いでいる．


```python
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation
from keras.optimizers import Adadelta


model = Sequential()
model.add(Dense(512, activation='relu', input_shape=(784,))) 
model.add(Dropout(0.2))## dropout()で過学習を抑制．
model.add(Dense(512, activation='relu')) 
model.add(Dropout(0.2))## dropout()で過学習を抑制．
model.add(Dense(10, activation='softmax'))


model.compile(loss='categorical_crossentropy',
              optimizer=keras.optimizers.Adadelta(),
              metrics=['accuracy'])
```


```python
batch_size = 128
epochs = 20
history = model.fit(x_train, y_train,
                    batch_size=batch_size, epochs=epochs,
                    verbose=1, validation_data=(x_test, y_test))
```

    Train on 60000 samples, validate on 10000 samples
    Epoch 1/20
    60000/60000 [==============================] - 21s - loss: 0.3602 - acc: 0.8959 - val_loss: 0.1609 - val_acc: 0.9517
    Epoch 2/20
    60000/60000 [==============================] - 18s - loss: 0.1556 - acc: 0.9540 - val_loss: 0.1114 - val_acc: 0.9667
    Epoch 3/20
    60000/60000 [==============================] - 15s - loss: 0.1121 - acc: 0.9658 - val_loss: 0.0936 - val_acc: 0.9712
    Epoch 4/20
    60000/60000 [==============================] - 14s - loss: 0.0885 - acc: 0.9726 - val_loss: 0.0741 - val_acc: 0.9781
    Epoch 5/20
    60000/60000 [==============================] - 12s - loss: 0.0734 - acc: 0.9782 - val_loss: 0.0719 - val_acc: 0.9779
    Epoch 6/20
    60000/60000 [==============================] - 12s - loss: 0.0607 - acc: 0.9816 - val_loss: 0.0654 - val_acc: 0.9791
    Epoch 7/20
    60000/60000 [==============================] - 13s - loss: 0.0518 - acc: 0.9840 - val_loss: 0.0669 - val_acc: 0.9796
    Epoch 8/20
    60000/60000 [==============================] - 13s - loss: 0.0454 - acc: 0.9858 - val_loss: 0.0629 - val_acc: 0.9806
    Epoch 9/20
    60000/60000 [==============================] - 13s - loss: 0.0391 - acc: 0.9882 - val_loss: 0.0614 - val_acc: 0.9810
    Epoch 10/20
    60000/60000 [==============================] - 13s - loss: 0.0354 - acc: 0.9891 - val_loss: 0.0614 - val_acc: 0.9816
    Epoch 11/20
    60000/60000 [==============================] - 15s - loss: 0.0310 - acc: 0.9903 - val_loss: 0.0576 - val_acc: 0.9833
    Epoch 12/20
    60000/60000 [==============================] - 15s - loss: 0.0286 - acc: 0.9911 - val_loss: 0.0573 - val_acc: 0.9831
    Epoch 13/20
    60000/60000 [==============================] - 15s - loss: 0.0262 - acc: 0.9922 - val_loss: 0.0585 - val_acc: 0.9831
    Epoch 14/20
    60000/60000 [==============================] - 16s - loss: 0.0221 - acc: 0.9929 - val_loss: 0.0561 - val_acc: 0.9845
    Epoch 15/20
    60000/60000 [==============================] - 15s - loss: 0.0196 - acc: 0.9940 - val_loss: 0.0567 - val_acc: 0.9835
    Epoch 16/20
    60000/60000 [==============================] - 14s - loss: 0.0184 - acc: 0.9943 - val_loss: 0.0575 - val_acc: 0.9830
    Epoch 17/20
    60000/60000 [==============================] - 13s - loss: 0.0164 - acc: 0.9953 - val_loss: 0.0572 - val_acc: 0.9837
    Epoch 18/20
    60000/60000 [==============================] - 13s - loss: 0.0153 - acc: 0.9953 - val_loss: 0.0626 - val_acc: 0.9828
    Epoch 19/20
    60000/60000 [==============================] - 15s - loss: 0.0142 - acc: 0.9956 - val_loss: 0.0630 - val_acc: 0.9820
    Epoch 20/20
    60000/60000 [==============================] - 16s - loss: 0.0133 - acc: 0.9959 - val_loss: 0.0615 - val_acc: 0.9831


## 改善の結果
　Dropoutを用いた結果，過学習を防ぐことができた．


```python
#正答率
plt.plot(history.history['acc'])
plt.plot(history.history['val_acc'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()
#loss
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()
```


![png](output_16_0.png)



![png](output_16_1.png)


 

## CNNによるMNIST分類の実装


```python
import keras
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras import backend as K

batch_size = 128
num_classes = 10
epochs = 12

img_rows, img_cols = 28, 28 ##画像のピクセル数

(x_train, y_train), (x_test, y_test) = mnist.load_data()

#Kerasのバックエンドで動くTensorFlowとTheanoでは入力チャンネルの順番が違うので場合分けして書いています
if K.image_data_format() == 'channels_first':
    x_train = x_train.reshape(x_train.shape[0], 1, img_rows, img_cols)
    x_test = x_test.reshape(x_test.shape[0], 1, img_rows, img_cols)
    input_shape = (1, img_rows, img_cols)
else:
    x_train = x_train.reshape(x_train.shape[0], img_rows, img_cols, 1)
    x_test = x_test.reshape(x_test.shape[0], img_rows, img_cols, 1)
    input_shape = (img_rows, img_cols, 1)


```

    a



```python
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255

print(x_train.shape[0], 'train samples')
print(x_test.shape[0], 'test samples')

y_train = y_train.astype('int32')
y_test = y_test.astype('int32')
y_train = keras.utils.np_utils.to_categorical(y_train, num_classes)
y_test =  keras.utils.np_utils.to_categorical(y_test, num_classes)

```


```python
model = Sequential()
model.add(Conv2D(32, kernel_size=(3, 3),
                 activation='relu',
                 input_shape=input_shape))
model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(num_classes, activation='softmax'))

model.compile(loss=keras.losses.categorical_crossentropy,
              optimizer=keras.optimizers.Adadelta(),
              metrics=['accuracy'])
history = model.fit(x_train, y_train, batch_size=batch_size, epochs=epochs,
          verbose=1, validation_data=(x_test, y_test))
```


```python
import matplotlib.pyplot as plt
#正答率
plt.plot(history.history['acc'])
plt.plot(history.history['val_acc'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()
#loss
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()
```" . 1) nil (1 . 1055) (t 22911 1974 0 0)))
