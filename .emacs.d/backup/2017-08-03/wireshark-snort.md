**Table of Contents**

- [wireshark](#wireshark)
    - [tsharkとは](#tsharkとは)
        - [コマンド](#コマンド)
- [実行例](#実行例)
    - [-D ネットワークインターフェース一覧](#-d-ネットワークインターフェース一覧)
    - [-a 時間指定](#-a-時間指定)
    - [-Y 表示フィルタ指定](#-y-表示フィルタ指定)
    - [-V 詳細表示](#-v-詳細表示)
    - [-R ディスプレイフィルタ](#-r-ディスプレイフィルタ)
        - [【よく使うディスプレイフィルタ】](#よく使うディスプレイフィルタ)
        - [実行結果の考察](#実行結果の考察)
        - [特異なパケットを探す．](#特異なパケットを探す)
            - [tcp.analysis.flags](#tcpanalysisflags)
            - [tcp.analysis.retransmission](#tcpanalysisretransmission)
            - [tcp.checksum_bad](#tcpchecksumbad)
        - [ネットワークの状態の確認のコマンド](#ネットワークの状態の確認のコマンド)
            - [tcp.analysis.ack_lost_segment](#tcpanalysisacklostsegment)
            - [tcp.analysis.duplicate_ack](#tcpanalysisduplicateack)
            - [tcp.analysis.fast_retransmission](#tcpanalysisfastretransmission)
            - [tcp.analysis.lost_segment](#tcpanalysislostsegment)
            - [tcp.analysis.out_of_order](#tcpanalysisoutoforder)
            - [tcp.analysis.window_full](#tcpanalysiswindowfull)
            - [tcp.analysis.zero_window](#tcpanalysiszerowindow)
    - [-Y キャプチャフィルタ](#-y-キャプチャフィルタ)
    - [実行結果](#実行結果)
    - [Wireshark 2.0 - Top 10 Filters (by Chris Greer)](#wireshark-20---top-10-filters-by-chris-greer)
        - [コマンド](#コマンド)
    - [tor](#tor)
- [wiresharkについての総括](#wiresharkについての総括)
- [wiresharkの参考文献](#wiresharkの参考文献)
- [snortとは](#snortとは)
    - [snortについて](#snortについて)
    - [help](#help)
    - [テスト実行](#テスト実行)
    - [設定ファイル場所](#設定ファイル場所)
    - [設定ファイル](#設定ファイル)
    - [エラーの例](#エラーの例)
    - [グローバルip](#グローバルip)
    - [最終的実行コマンド](#最終的実行コマンド)
    - [local.rule](#localrule)
        - [icmpパケットとは](#icmpパケットとは)
        - [pingキャプチャの結果の一部](#pingキャプチャの結果の一部)
    - [プリンタへの接続を確認していると思われるping](#プリンタへの接続を確認していると思われるping)
        - [先生の談](#先生の談)
    - [2017-07-20時点の課題](#2017-07-20時点の課題)
        - [和田先生に対して](#和田先生に対して)
        - [調査した結果](#調査した結果)
            - [パスワードについて](#パスワードについて)
        - [対応](#対応)
- [実行結果](#実行結果)
- [実行結果2](#実行結果2)
- [実行結果3](#実行結果3)
- [logの見方](#logの見方)
    - [logファイルの場所](#logファイルの場所)
    - [snortによる実験の考察](#snortによる実験の考察)
    - [実験の意義](#実験の意義)
- [snortの参考文献](#snortの参考文献)



# wireshark
## tsharkとは
コマンドラインで使えるwiresharkのこと
### コマンド
オプション名	説明
-f ＜キャプチャフィルタ＞	キャプチャフィルタを指定する
-i ＜インターフェイス＞	キャプチャ対象のネットワークインターフェイスを指定する
-w ＜ファイル名＞	出力ファイル名を指定する
-a ＜条件＞	時間/ファイルサイズ/ファイル数などの条件を満たしたらパケットキャプチャを終了する
-r ＜ファイル名＞	指定したファイルを読み込む
-D	キャプチャ対象として指定できるネットワークインターフェイス一覧を表示して終了する
-V	キャプチャしたパケットの詳細を標準出力に表示する
-Y ＜表示フィルタ＞	表示フィルタを指定する

# 実行例
## -D ネットワークインターフェース一覧

[n-lab@d-lab2]~% sudo tshark -D
1. enp0s29f7u2
2. virbr0
3. bluetooth0
4. nflog
5. nfqueue
6. usbmon1
7. usbmon2
8. usbmon3
9. usbmon4
10. usbmon5
11. usbmon6
12. usbmon7
13. enp9s0
14. wlp11s0
15. any
16. lo (Loopback)

## -a 時間指定

次の例は、10秒間のキャプチャを実行し、キャプチャ結果を「./capture1」というファイルに保存するものだ。

```
# tshark -i eth0 -w ./capture1 -a duration:10
```

## -Y 表示フィルタ指定
## -V 詳細表示
```
[root@d-lab2]/home/n-lab# tshark -i 1 -Y http -a duration:10 -V
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
Frame 11: 221 bytes on wire (1768 bits), 221 bytes captured (1768 bits) on interface 0
    Interface id: 0
    Encapsulation type: Ethernet (1)
    Arrival Time: Jul 13, 2017 04:57:20.510111977 JST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1499889440.510111977 seconds
    [Time delta from previous captured frame: 0.005119942 seconds]
    [Time delta from previous displayed frame: 0.000000000 seconds]
    [Time since reference or first frame: 0.729173903 seconds]
    Frame Number: 11
    Frame Length: 221 bytes (1768 bits)
    Capture Length: 221 bytes (1768 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ip:udp:http]
Ethernet II, Src: AsixElec_e2:93:0d (00:0e:c6:e2:93:0d), Dst: IPv4mcast_7f:ff:fa (01:00:5e:7f:ff:fa)
    Destination: IPv4mcast_7f:ff:fa (01:00:5e:7f:ff:fa)
        Address: IPv4mcast_7f:ff:fa (01:00:5e:7f:ff:fa)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...1 .... .... .... .... = IG bit: Group address (multicast/broadcast)
    Source: AsixElec_e2:93:0d (00:0e:c6:e2:93:0d)
        Address: AsixElec_e2:93:0d (00:0e:c6:e2:93:0d)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IP (0x0800)
    Frame check sequence: 0x819171fa [correct]
        [FCS Good: True]

(中略)


	Identification: 0xc5e4 (50660)
    Flags: 0x00
        0... .... = Reserved bit: Not set
        .0.. .... = Don't fragment: Not set
        ..0. .... = More fragments: Not set
    Fragment offset: 0
    Time to live: 1
    Protocol: UDP (17)
    Header checksum: 0xf430 [validation disabled]
        [Good: False]
        [Bad: False]
    Source: 10.0.5.19 (10.0.5.19)
    Destination: 239.255.255.250 (239.255.255.250)
User Datagram Protocol, Src Port: 58447 (58447), Dst Port: ssdp (1900)
    Source port: 58447 (58447)
    Destination port: ssdp (1900)
    Length: 183
    Checksum: 0x328c [validation disabled]
        [Good Checksum: False]
        [Bad Checksum: False]
Hypertext Transfer Protocol
    M-SEARCH * HTTP/1.1\r\n
        [Expert Info (Chat/Sequence): M-SEARCH * HTTP/1.1\r\n]
            [Message: M-SEARCH * HTTP/1.1\r\n]
            [Severity level: Chat]
            [Group: Sequence]
        Request Method: M-SEARCH
        Request URI: *
        Request Version: HTTP/1.1
    HOST: 239.255.255.250:1900\r\n
    MAN: "ssdp:discover"\r\n
    MX: 1\r\n
    ST: urn:dial-multiscreen-org:service:dial:1\r\n
    USER-AGENT: Google Chrome/58.0.3029.110 Mac OS X\r\n
    \r\n
    [Full request URI: http://239.255.255.250:1900*]
    [HTTP request 3/3]
    [Prev request in frame: 63]

112 packets dropped
9 packets captured

```

## -R ディスプレイフィルタ
### 【よく使うディスプレイフィルタ】
以下、よく使うディスプレイフィルタを紹介します。
以下のリストは、lovemytoolのサイトで紹介されていたChris Greer 氏によるTop 10です。

ディスプレイフィルタの構文					説明
ip.addr == 10.0.0.1						送信元、もしくは送信先が10.0.0.1であるパケットを表示
ip.addr==10.0.0.1  && ip.addr==10.0.0.2	10.0.0.1と10.0.0.2間の通信を表示
http or dns								HTTP、もしくはDNSを表示
tcp.port==4000								ポートが4000の物を表示
tcp.flags.reset==1							TCPのリセットを表示
http.request								HTTP GETを表示
tcp contains traffic						TCPパケットに’traffic’という単語を含んでいる物を表示。ユーザーIDといった特定の文字列を含んでいるパケットを調べる際に便利。
!(arp or icmp or dns)						ARPやICMPやDNSでないプロトコルを表示。調べたいパケットに集中することができる。
udp contains 33:27:58						“0x33 0x27 0x58”を含むUDPを表示
tcp.analysis.retransmission				TCPのRetransmission (= 再送) を表示。アプリのパフォーマンス問題、パケットロス時のトラブルシューティングに便利。



tcp.analysis.ack_lost_segment
パケットがロストしている
tcp.analysis.duplicate_ack
パケットが重複している
tcp.analysis.fast_retransmission
再送が発生している
tcp.analysis.lost_segment
パケットがロストしている
tcp.analysis.out_of_order
パケットの到達順序が入れ替わっている
tcp.analysis.retransmission
再送が発生している
tcp.analysis.window_full
データ受信が遅くなっている
tcp.analysis.zero_window
データ順が遅くなっている


### 実行結果の考察
学外からsizeの大きいpingを打つ．これにより，パケットロスが起きる可能性がある．
学科のサーバーは帯域が広いため，あまりパケットロスは起きないと考えられる．
また，あまりにサイズが大きい場合，ルーターが弾く．また，悪意あると判断され，ipアドレスがブラックリストに乗るとも考えられる．


### 特異なパケットを探す．
探した結果，思った結果は得られなかった．
また，外部からpingを打っても，timeoutしたため，大きいサイズのパケットは打てなかった．

#### tcp.analysis.flags

異常なパケットはあるかどうか

```
[root@d-lab2]/home/n-lab# sudo tshark -i 1 -R "tcp.analysis.flags" -a duration:10
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
 0 packets captured


```


```
[root@d-lab2]~# sudo tshark -i 1 -Y "tcp.analysis.flags" -a duration:10 
Running as user "root" and group "root". This could be dangerous.
Capnturing on 'enp0s29f7u2'
0 packets captured

```

下記実行結果には "[TCP Retransmission] Application Data"とある．

#### tcp.analysis.retransmission

再送があるかないかを確認する．


TCPでは、TCPデータの送信者が、受信者からACKを受け取れなかった場合、TCPデータの再送(=Retransmit)を行う．

```
[root@d-lab2]/home/n-lab# sudo tshark -i 1 -R "tcp.analysis.retransmission" -a duration:10
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
 88 7.657530376 2404:6800:4008:c00::bc -> 2001:2f8:1c:a504:38bb:f7a2:cd58:46cf TLSv1.2 121 [TCP Retransmission] Application Data
 96 7.925385402 2404:6800:4008:c00::bc -> 2001:2f8:1c:a504:38bb:f7a2:cd58:46cf TLSv1.2 121 [TCP Retransmission] Application Data
102 8.461558522 2404:6800:4008:c00::bc -> 2001:2f8:1c:a504:38bb:f7a2:cd58:46cf TLSv1.2 121 [TCP Retransmission] Application Data
123 9.533597169 2404:6800:4008:c00::bc -> 2001:2f8:1c:a504:38bb:f7a2:cd58:46cf TLSv1.2 121 [TCP Retransmission] Application Data
4 packets captured

```

再送がない場合もある．


```
[root@d-lab2]/home/n-lab# sudo tshark -i 1 -R "tcp.analysis.retransmission" -a duration:10 -V
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured

```

#### tcp.checksum_bad

データ転送が正しくなされたことを調べる

```
[root@d-lab2]/home/n-lab# sudo tshark -i 1 -R "tcp.checksum_bad" -a duration:10 -V
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
```



### ネットワークの状態の確認のコマンド
以下に代表的コマンドを示す．

#### tcp.analysis.ack_lost_segment

パケットがロストしている

```
[root@d-lab2]~# sudo tshark -i 1 -a duration:10 -R "tcp.analysis.ack_lost_segment"
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]~# sudo tshark -i 1 -a duration:10 -Y "tcp.analysis.ack_lost_segment"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
```

#### tcp.analysis.duplicate_ack
パケットが重複している

#### tcp.analysis.fast_retransmission
再送が発生している

```
[root@d-lab2]~# sudo tshark -i 1 -a duration:10 -Y "tcp.analysis.fast_retransmission"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
```


#### tcp.analysis.lost_segment
パケットがロストしている
```
[root@d-lab2]~# sudo tshark -i 1 -a duration:10 -Y "tcp.analysis.lost_segment"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured

```

#### tcp.analysis.out_of_order
パケットの到達順序が入れ替わっている
```
[root@d-lab2]~# sudo tshark -i 1 -a duration:10 -Y "tcp.analysis.out_of_order"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured

```


#### tcp.analysis.window_full
データ受信が遅くなっている

```
[root@d-lab2]~# sudo tshark -i 1 -a duration:10 -Y "tcp.analysis.window_full"   
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured

```
#### tcp.analysis.zero_window
データ順が遅くなっている

```
[root@d-lab2]~# sudo tshark -i 1 -a duration:10 -Y "tcp.analysis.zero_window"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured

```

## -Y キャプチャフィルタ
表示フィルタは全てのフレームを取得した後、表示だけに適用される。
キャプチャフィルタはキャプチャの時、ルールを決める。
```
[root@d-lab2]/home/n-lab# tshark -i 1 -Y "http or dns" -a duration:1 -V
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
Frame 5: 107 bytes on wire (856 bits), 107 bytes captured (856 bits) on interface 0
    Interface id: 0
    Encapsulation type: Ethernet (1)
    Arrival Time: Jul 13, 2017 05:21:57.827463385 JST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1499890917.827463385 seconds
    [Time delta from previous captured frame: 0.135132077 seconds]
    [Time delta from previous displayed frame: 0.000000000 seconds]
    [Time since reference or first frame: 0.415289473 seconds]
    Frame Number: 5
    Frame Length: 107 bytes (856 bits)
    Capture Length: 107 bytes (856 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ip:udp:dns]
Ethernet II, Src: Dell_02:67:b8 (a4:ba:db:02:67:b8), Dst: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
    Destination: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
        Address: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...1 .... .... .... .... = IG bit: Group address (multicast/broadcast)
    Source: Dell_02:67:b8 (a4:ba:db:02:67:b8)
        Address: Dell_02:67:b8 (a4:ba:db:02:67:b8)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IP (0x0800)
    Frame check sequence: 0x326f3641 [correct]
        [FCS Good: True]
        [FCS Bad: False]
Internet Protocol Version 4, Src: 10.0.0.45 (10.0.0.45), Dst: 224.0.0.251 (224.0.0.251)
    Version: 4
    Header length: 20 bytes
    Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 0x00: Not-ECT (Not ECN-Capable Transport))
        0000 00.. = Differentiated Services Codepoint: Default (0x00)
        .... ..00 = Explicit Congestion Notification: Not-ECT (Not ECN-Capable Transport) (0x00)
    Total Length: 89
    Identification: 0x56cf (22223)
    Flags: 0x00
        0... .... = Reserved bit: Not set
        .0.. .... = Don't fragment: Not set
        ..0. .... = More fragments: Not set
    Fragment offset: 0
    Time to live: 255
    Protocol: UDP (17)
    Header checksum: 0x799c [validation disabled]
        [Good: False]
        [Bad: False]
    Source: 10.0.0.45 (10.0.0.45)
    Destination: 224.0.0.251 (224.0.0.251)
User Datagram Protocol, Src Port: mdns (5353), Dst Port: mdns (5353)
    Source port: mdns (5353)
    Destination port: mdns (5353)
    Length: 69
    Checksum: 0xa3d9 [validation disabled]
        [Good Checksum: False]
        [Bad Checksum: False]
Domain Name System (response)
    Transaction ID: 0x0000
    Flags: 0x8400 Standard query response, No error
        1... .... .... .... = Response: Message is a response
        .000 0... .... .... = Opcode: Standard query (0)
        .... .1.. .... .... = Authoritative: Server is an authority for domain
        .... ..0. .... .... = Truncated: Message is not truncated
        .... ...0 .... .... = Recursion desired: Don't do query recursively
        .... .... 0... .... = Recursion available: Server can't do recursive queries
        .... .... .0.. .... = Z: reserved (0)
        .... .... ..0. .... = Answer authenticated: Answer/authority portion was not authenticated by the server
        .... .... ...0 .... = Non-authenticated data: Unacceptable
        .... .... .... 0000 = Reply code: No error (0)
    Questions: 0
    Answer RRs: 1
    Authority RRs: 0
    Additional RRs: 0
    Answers
        _rp-media._tcp.local: type PTR, class IN, PROFASHARIFDSP._rp-media._tcp.local
            Name: _rp-media._tcp.local
            Type: PTR (Domain name pointer)
            .000 0000 0000 0001 = Class: IN (0x0001)
            0... .... .... .... = Cache flush: False
            Time to live: 0 seconds
            Data length: 17
            Domain Name: PROFASHARIFDSP._rp-media._tcp.local

Frame 6: 107 bytes on wire (856 bits), 107 bytes captured (856 bits) on interface 0
    Interface id: 0
    Encapsulation type: Ethernet (1)
    Arrival Time: Jul 13, 2017 05:21:57.943849723 JST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1499890917.943849723 seconds
    [Time delta from previous captured frame: 0.116386338 seconds]
    [Time delta from previous displayed frame: 0.116386338 seconds]
    [Time since reference or first frame: 0.531675811 seconds]
    Frame Number: 6
    Frame Length: 107 bytes (856 bits)
    Capture Length: 107 bytes (856 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ip:udp:dns]
Ethernet II, Src: Dell_02:67:b8 (a4:ba:db:02:67:b8), Dst: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
    Destination: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
        Address: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...1 .... .... .... .... = IG bit: Group address (multicast/broadcast)
    Source: Dell_02:67:b8 (a4:ba:db:02:67:b8)
        Address: Dell_02:67:b8 (a4:ba:db:02:67:b8)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IP (0x0800)
    Frame check sequence: 0x69d1eaac [correct]
        [FCS Good: True]
        [FCS Bad: False]
Internet Protocol Version 4, Src: 10.0.0.45 (10.0.0.45), Dst: 224.0.0.251 (224.0.0.251)
    Version: 4
    Header length: 20 bytes
    Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 0x00: Not-ECT (Not ECN-Capable Transport))
        0000 00.. = Differentiated Services Codepoint: Default (0x00)
        .... ..00 = Explicit Congestion Notification: Not-ECT (Not ECN-Capable Transport) (0x00)
    Total Length: 89
    Identification: 0x56d0 (22224)
    Flags: 0x00
        0... .... = Reserved bit: Not set
        .0.. .... = Don't fragment: Not set
        ..0. .... = More fragments: Not set
    Fragment offset: 0
    Time to live: 255
    Protocol: UDP (17)
    Header checksum: 0x799b [validation disabled]
        [Good: False]
        [Bad: False]
    Source: 10.0.0.45 (10.0.0.45)
    Destination: 224.0.0.251 (224.0.0.251)
User Datagram Protocol, Src Port: mdns (5353), Dst Port: mdns (5353)
    Source port: mdns (5353)
    Destination port: mdns (5353)
    Length: 69
    Checksum: 0x9245 [validation disabled]
        [Good Checksum: False]
        [Bad Checksum: False]
Domain Name System (response)
    Transaction ID: 0x0000
    Flags: 0x8400 Standard query response, No error
        1... .... .... .... = Response: Message is a response
        .000 0... .... .... = Opcode: Standard query (0)
        .... .1.. .... .... = Authoritative: Server is an authority for domain
        .... ..0. .... .... = Truncated: Message is not truncated
        .... ...0 .... .... = Recursion desired: Don't do query recursively
        .... .... 0... .... = Recursion available: Server can't do recursive queries
        .... .... .0.. .... = Z: reserved (0)
        .... .... ..0. .... = Answer authenticated: Answer/authority portion was not authenticated by the server
        .... .... ...0 .... = Non-authenticated data: Unacceptable
        .... .... .... 0000 = Reply code: No error (0)
    Questions: 0
    Answer RRs: 1
    Authority RRs: 0
    Additional RRs: 0
    Answers
        _rp-media._tcp.local: type PTR, class IN, PROFASHARIFDSP._rp-media._tcp.local
            Name: _rp-media._tcp.local
            Type: PTR (Domain name pointer)
            .000 0000 0000 0001 = Class: IN (0x0001)
            0... .... .... .... = Cache flush: False
            Time to live: 1 hour, 15 minutes
            Data length: 17
            Domain Name: PROFASHARIFDSP._rp-media._tcp.local

Frame 7: 134 bytes on wire (1072 bits), 134 bytes captured (1072 bits) on interface 0
    Interface id: 0
    Encapsulation type: Ethernet (1)
    Arrival Time: Jul 13, 2017 05:21:58.043925308 JST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1499890918.043925308 seconds
    [Time delta from previous captured frame: 0.100075585 seconds]
    [Time delta from previous displayed frame: 0.100075585 seconds]
    [Time since reference or first frame: 0.631751396 seconds]
    Frame Number: 7
    Frame Length: 134 bytes (1072 bits)
    Capture Length: 134 bytes (1072 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ip:udp:dns]
Ethernet II, Src: Dell_02:67:b8 (a4:ba:db:02:67:b8), Dst: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
    Destination: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
        Address: IPv4mcast_00:00:fb (01:00:5e:00:00:fb)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...1 .... .... .... .... = IG bit: Group address (multicast/broadcast)
    Source: Dell_02:67:b8 (a4:ba:db:02:67:b8)
        Address: Dell_02:67:b8 (a4:ba:db:02:67:b8)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IP (0x0800)
    Frame check sequence: 0xf597f061 [correct]
        [FCS Good: True]
        [FCS Bad: False]
Internet Protocol Version 4, Src: 10.0.0.45 (10.0.0.45), Dst: 224.0.0.251 (224.0.0.251)
    Version: 4
    Header length: 20 bytes
    Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 0x00: Not-ECT (Not ECN-Capable Transport))
        0000 00.. = Differentiated Services Codepoint: Default (0x00)
        .... ..00 = Explicit Congestion Notification: Not-ECT (Not ECN-Capable Transport) (0x00)
    Total Length: 116
    Identification: 0x56d1 (22225)
    Flags: 0x00
        0... .... = Reserved bit: Not set
        .0.. .... = Don't fragment: Not set
        ..0. .... = More fragments: Not set
    Fragment offset: 0
    Time to live: 255
    Protocol: UDP (17)
    Header checksum: 0x797f [validation disabled]
        [Good: False]
        [Bad: False]
    Source: 10.0.0.45 (10.0.0.45)
    Destination: 224.0.0.251 (224.0.0.251)
User Datagram Protocol, Src Port: mdns (5353), Dst Port: mdns (5353)
    Source port: mdns (5353)
    Destination port: mdns (5353)
    Length: 96
    Checksum: 0x888b [validation disabled]
        [Good Checksum: False]
        [Bad Checksum: False]
Domain Name System (query)
    Transaction ID: 0x0000
    Flags: 0x0000 Standard query
        0... .... .... .... = Response: Message is a query
        .000 0... .... .... = Opcode: Standard query (0)
        .... ..0. .... .... = Truncated: Message is not truncated
        .... ...0 .... .... = Recursion desired: Don't do query recursively
        .... .... .0.. .... = Z: reserved (0)
        .... .... ...0 .... = Non-authenticated data: Unacceptable
    Questions: 1
    Answer RRs: 0
    Authority RRs: 1
    Additional RRs: 0
    Queries
        PROFASHARIFDSP._rp-media._tcp.local: type ANY, class IN, "QM" question
            Name: PROFASHARIFDSP._rp-media._tcp.local
            Type: ANY (Request for all records)
            .000 0000 0000 0001 = Class: IN (0x0001)
            0... .... .... .... = "QU" question: False
    Authoritative nameservers
        PROFASHARIFDSP._rp-media._tcp.local: type SRV, class IN, priority 0, weight 0, port 20121, target ProfAsharifDSP.local
            Service: PROFASHARIFDSP
            Protocol: _rp-media
            Name: _tcp.local
            Type: SRV (Service location)
            .000 0000 0000 0001 = Class: IN (0x0001)
            0... .... .... .... = Cache flush: False
            Time to live: 2 minutes
            Data length: 23
            Priority: 0
            Weight: 0
            Port: 20121
            Target: ProfAsharifDSP.local

3 packets captured

```
## 実行結果
反応がない
これは，

```
[root@d-lab2]/home/n-lab# tshark -i 1 -Y "ip.addr == 10.0.0.1" -a duration:1
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -R "ip.addr == 10.0.0.1" -a duration:1 
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -R "tcp.port==4000" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -R "tcp.flags.reset==1" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -Y "tcp.port==4000" -a duration:1   
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -R "http.request" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -R "tcp contains traffic" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -R "tcp contains e15" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -R "tcp contains e15" -a duration:1    
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
```

```
[root@d-lab2]/home/n-lab# tshark -i 1 -R "!(arp or icmp or dns)" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
  1 0.000000000 Buffalo_c0:29:25 -> Broadcast    0x8899 64 Ethernet II
  3 0.146749778 Buffalo_67:3b:eb -> Broadcast    0x8899 64 Ethernet II
  4 0.327141978 Buffalo_35:6c:5b -> Broadcast    0x8899 64 Ethernet II
3 packets captured

```


```
[root@d-lab2]/home/n-lab# tshark -i 1 -R "udp contains 33:27:58" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -Y "udp contains 33:27:58" -a duration:1
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
[root@d-lab2]/home/n-lab# tshark -i 1 -R "tcp.analysis.retransmission" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured

```

## Wireshark 2.0 - Top 10 Filters (by Chris Greer)
### コマンド

ip.addr == 10.0.0.1 (Classic. Sets a filter for any packet with 10.0.0.1 as the source or dest IP)

ip.addr eq 10.0.0.1 and ip.addr eq 192.168.1.1 (Sets a conversation filter between two IP's)

ip.addr == 10.0.0.0/24 (Subnet filter. Displays any conversation to or from any IP in the 10.0.0.0/24 subnet) 

tcp or dns (Sets a filter for all packets containing TCP and those with DNS)

tcp.analysis.flags (Displays any packet with TCP warnings or info, including retransmissions, duplicate acks, window updates and Out-of-Orders. Also, TCP problems are automatically displayed on the sidebar of the summary view of wireshark. Look for dark lines on the scroll bar as you go through a trace. Great info to spot the bad stuff!)

tcp contains facebook (Shows all TCP packets that contain the word "facebook". This word could be replaced with any clear-text string you are searching for)

http.request or http.response (This will display all HTTP request strings along with the response codes. Look for HTTP 500 and 404 responses as these indicate a problem)

http.time > 2 (Displays all HTTP responses that were sent more than 2 seconds after the request. Awesome way to measure HTTP performance!! Also great to add as a column)

!(arp or dns or icmp) - (Masks out arp, dns, icmp, or whatever other protocols that may be clouding an issue)

tcp.stream eq 0 (This is best to apply by right-clicking a TCP packet in a connection that you want to display and selecting Follow | TCP Stream. This will display all packets in the TCP conversation as well as the packet content if not encrypted)

One more - I know this is 11, but it's a great one too. 

sip or rtp (This displays all sip control and rtp frames in the trace) 

These are some useful display filters to keep around when digging through trace files. These definitely include my favorites. Did I miss any of your common display filters? Please share below! 

Got a tough network problem? Contact me by clicking here.


```
[root@d-lab2]/home/n-lab# tshark -i 1 -R "http.request or http.response" -a duration:10
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
 15 1.237153974   10.0.2.232 -> 239.255.255.250 SSDP 220 M-SEARCH * HTTP/1.1 
 26 2.237214445   10.0.2.232 -> 239.255.255.250 SSDP 220 M-SEARCH * HTTP/1.1 
 73 7.578576897   10.0.2.232 -> 239.255.255.250 SSDP 220 M-SEARCH * HTTP/1.1 
3 packets captured
```



```
[root@d-lab2]/home/n-lab# tshark -i 1 -Y "ip.addr eq 10.0.0.1 and ip.addr eq 192.168.1.1" -a duration:10
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
0 packets captured
```

```
[root@d-lab2]/home/n-lab# tshark -i 1 -R "http.request or http.response" -a duration:1
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
  7 0.400555509   10.0.1.184 -> 239.255.255.250 SSDP 221 M-SEARCH * HTTP/1.1 
1 packet captured

```


## tor
torはsslを使っているようだから，torブラウザのを使ってみて，検証する．
```
[root@d-lab2]/home/n-lab# tshark -i 1 -R "ssl"  -a duration:10 
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s29f7u2'
  8 0.775729911 49.102.153.234 -> 10.0.1.113   TLSv1.2 108 Application Data
1 packet captured

```

# wiresharkについての総括
　wiresharkを用いた学科サーバーのパケットのキャプチャを行い，キャプチャできる範囲で，再送が起きていることが分かった．拾える帯域が大きい端末ならば，より良い結果が得られただろう．



# wiresharkの参考文献
http://www.lovemytool.com/blog/2016/02/wireshark-20-top-10-filters-by-chris-greer.html
http://n.pentest.ninja/?p=202















# snortとは
不正侵入検出ソフトウェアのこと．IDS（Intrusion Detection System）とも呼ばれる．

## snortについて

## help
Options:
        -A         Set alert mode: fast, full, console, test or none  (alert file alerts only)
                   "unsock" enables UNIX socket logging (experimental).
        -b         Log packets in tcpdump format (much faster!)
        -B <mask>  Obfuscated IP addresses in alerts and packet dumps using CIDR mask
        -c <rules> Use Rules File <rules>
        -C         Print out payloads with character data only (no hex)
        -d         Dump the Application Layer
        -D         Run Snort in background (daemon) mode
        -e         Display the second layer header info
        -f         Turn off fflush() calls after binary log writes
        -F <bpf>   Read BPF filters from file <bpf>
        -g <gname> Run snort gid as <gname> group (or gid) after initialization
        -G <0xid>  Log Identifier (to uniquely id events for multiple snorts)

## テスト実行

```
[root@d-lab2]/var/log/snort# snort -T -c /etc/snort/snort.conf
Running in Test mode

        --== Initializing Snort ==--
Initializing Output Plugins!
Initializing Preprocessors!
Initializing Plug-ins!
Parsing Rules file "/etc/snort/snort.conf"
PortVar 'HTTP_PORTS' defined :  [ 80:81 311 383 591 593 901 1220 1414 1741 1830 2301 2381 2809 3037 3128 3702 4343 4848 5250 6988 7000:7001 7144:7145 7510 7777 7779 8000 8008 8014 8028 8080 8085 8088 8090 8118 8123 8180:8181 8243 8280 8300 8800 8888 8899 9000 9060 9080 9090:9091 9443 9999 11371 34443:34444 41080 50002 55555 ]
PortVar 'SHELLCODE_PORTS' defined :  [ 0:79 81:65535 ]
PortVar 'ORACLE_PORTS' defined :  [ 1024:65535 ]
PortVar 'SSH_PORTS' defined :  [ 22 ]
PortVar 'FTP_PORTS' defined :  [ 21 2100 3535 ]
PortVar 'SIP_PORTS' defined :  [ 5060:5061 5600 ]
PortVar 'FILE_DATA_PORTS' defined :  [ 80:81 110 143 311 383 591 593 901 1220 1414 1741 1830 2301 2381 2809 3037 3128 3702 4343 4848 5250 6988 7000:7001 7144:7145 7510 7777 7779 8000 8008 8014 8028 8080 8085 8088 8090 8118 8123 8180:8181 8243 8280 8300 8800 8888 8899 9000 9060 9080 9090:9091 9443 9999 1


(中略)



WARNING: flowbits key 'file.ht3' is set but not ever checked.
328 out of 1024 flowbits in use.

[ Port Based Pattern Matching Memory ]
+- [ Aho-Corasick Summary ] -------------------------------------
| Storage Format    : Full-Q 
| Finite Automaton  : DFA
| Alphabet Size     : 256 Chars
| Sizeof State      : Variable (1,2,4 bytes)
| Instances         : 373
|     1 byte states : 356
|     2 byte states : 17
|     4 byte states : 0
| Characters        : 195395
| States            : 151912
| Transitions       : 22790348
| State Density     : 58.6%
| Patterns          : 9967
| Match States      : 10770
| Memory (MB)       : 78.27
|   Patterns        : 1.13
|   Match Lists     : 2.53
|   DFA
|     1 byte states : 2.02
|     2 byte states : 71.93
|     4 byte states : 0.00
+----------------------------------------------------------------
[ Number of patterns truncated to 20 bytes: 553 ]

        --== Initialization Complete ==--

   ,,_     -*> Snort! <*-
  o"  )~   Version 2.9.8.2 GRE (Build 335) 
   ''''    By Martin Roesch & The Snort Team: http://www.snort.org/contact#team
           Copyright (C) 2014-2015 Cisco and/or its affiliates. All rights reserved.
           Copyright (C) 1998-2013 Sourcefire, Inc., et al.
           Using libpcap version 1.5.3
           Using PCRE version: 8.32 2012-11-30
           Using ZLIB version: 1.2.7

           Rules Engine: SF_SNORT_DETECTION_ENGINE  Version 2.6  <Build 1>
           Preprocessor Object: SF_SSLPP  Version 1.1  <Build 4>
           Preprocessor Object: SF_SSH  Version 1.1  <Build 3>
           Preprocessor Object: SF_SMTP  Version 1.1  <Build 9>
           Preprocessor Object: SF_SIP  Version 1.1  <Build 1>
           Preprocessor Object: SF_SDF  Version 1.1  <Build 1>
           Preprocessor Object: SF_REPUTATION  Version 1.1  <Build 1>
           Preprocessor Object: SF_POP  Version 1.0  <Build 1>
           Preprocessor Object: SF_MODBUS  Version 1.1  <Build 1>
           Preprocessor Object: SF_IMAP  Version 1.0  <Build 1>
           Preprocessor Object: SF_GTP  Version 1.1  <Build 1>
           Preprocessor Object: SF_FTPTELNET  Version 1.2  <Build 13>
           Preprocessor Object: SF_DNS  Version 1.1  <Build 4>
           Preprocessor Object: SF_DNP3  Version 1.1  <Build 1>
           Preprocessor Object: SF_DCERPC2  Version 1.0  <Build 3>

Snort successfully validated the configuration!
Snort exiting

```

## 設定ファイル場所


[n-lab@d-lab2]~% sudo find / -type f -name snort.conf
/home/n-lab/snort/etc/snort.conf
/home/n-lab/snort/community-rules/snort.conf
/etc/snort/snort.conf
/etc/snort/rules/snort.conf　### これ

## 設定ファイル

[root@d-lab2]/home/n-lab# vim /etc/snort/rules/snort.conf


## エラーの例

ERROR: /etc/snort/rules/snort.conf(243) Could not stat dynamic module path "/usr/local/lib/snort_dynamicpreprocessor/": No such file or directory.

dynamicengine /usr/local/lib/snort_dynamicengine/libsf_engine.so

wget http://www.snort.org/dl/snort-current/snort-2.9.5.6.tar.gz    -O snort-2.9.5.6.tar.gz

[root@d-lab2]/usr/local/src# curl ifconfig.me
133.13.48.133


## グローバルip
[root@d-lab2]/etc/snort# curl ifconfig.co
133.13.48.133


## 最終的実行コマンド
[root@d-lab2]/var/log/snort# snort -c /etc/snort/snort.conf -l /var/log/snort/ -i enp0s29f7u2 -A fast -b -d -D



## local.rule
pingをキャプチャするルール設定．
```
# vi /etc/snort/rules/local.rules
 
alert icmp any any -> any any (msg:"ICMP Testing Rule"; sid:1000001; rev:1;)
```
### icmpパケットとは
「ICMP」は”Internet Control Message Protocol”の略で、文字通りIPメッセージ
が送信元から相手に届くまでの間に起きたエラー関連の情報を送信元に通知するためのプロトコル

### pingキャプチャの結果の一部
```
[n-lab@d-lab2]/var/log/snort% tail alert
07/20-14:57:06.593257  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::c57:b986:89e1:a59 -> ff02::16
07/20-14:57:06.772969  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff29:1b8b
07/20-14:57:10.241795  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} 2001:2f8:1c:a504:4c8:216e:7770:afaa -> ff02::1:ff15:d29f
07/20-14:57:11.243029  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} 2001:2f8:1c:a504:4c8:216e:7770:afaa -> ff02::1:ff15:d29f
07/20-14:57:12.244137  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} 2001:2f8:1c:a504:4c8:216e:7770:afaa -> ff02::1:ff15:d29f
07/20-14:57:14.246685  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} 2001:2f8:1c:a504:4c8:216e:7770:afaa -> ff02::1:ff15:d29f
07/20-14:57:14.358106  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} 2001:2f8:1c:a504:4c8:216e:7770:afaa -> ff02::1:ff15:d29f
07/20-14:57:15.369164  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} 2001:2f8:1c:a504:4c8:216e:7770:afaa -> ff02::1:ff15:d29f
07/20-14:57:33.960952  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff7c:d917
07/20-14:57:35.051162  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff7c:d917
[n-lab@d-lab2]/var/log/snort% tail alert                  
07/20-15:05:03.938349  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff81:400f
07/20-15:05:04.999285  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff81:400f
07/20-15:05:07.088632  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff81:400f
07/20-15:05:08.197968  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff81:400f
07/20-15:05:09.258255  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8a90:8dff:feb9:74e7 -> ff02::1:ff81:400f
07/20-15:05:26.764798  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8ced:9b94:2458:4018 -> ff02::16
07/20-15:05:26.783533  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8ced:9b94:2458:4018 -> ff02::16
07/20-15:05:26.785550  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8ced:9b94:2458:4018 -> ff02::16
07/20-15:05:26.787695  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8ced:9b94:2458:4018 -> ff02::16
07/20-15:05:27.129712  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {IPV6-ICMP} fe80::8ced:9b94:2458:4018 -> ff02::16
```

## プリンタへの接続を確認していると思われるping

07/20-15:09:36.674907  [**] [1:1000001:1] ICMP Testing Rule [**] [Priority: 0] {ICMP} 10.100.10.40 -> 10.0.1.216

10.0.1.216をブラウザ打ったら，fujixeroxのプリンタだった．これはネットワークに繋がったプリンタに対して，接続を確認していると思われる．

### 先生の談
nakagusukuに対し，接続したいprinterが要求するパケットを投げ，それを拒否するパケットが帰ってきた際のlogであると考えられる．


15:09:36.674907 IP nakagusuku.ie.u-ryukyu.ac.jp > mono.lsi.ie.u-ryukyu.ac.jp: ICMP nakagusuku.ie.u-ryukyu.ac.jp udp port netbios-dgm unreachable, length 237


## 2017-07-20時点の課題

### 和田先生に対して
winsサーバーの設定項目など．
printerの接続先が，nakagusukuにアクセスしていないかを調べる

### 調査した結果
和田研の方に伺った所，2017-07-20朝時点で，不調だったとのこと．
数日前の停電からおかしくなったらしい．
品番 docuprint c3350

応急処置として，電源を落とし，使用する際には，有線でネットに繋がずに使っていただくようにした．

#### パスワードについて
defaultのパスワードを入力した結果，入れた．

```
About Usernames and Passwords	
 For links with a Red Key() specify a username of 'admin' (case sensitive). The default 'admin' password is 'access'. 

 For links with a Green Key() specify a username of 'user' (case sensitive). The default 'user' password is 'access'. 

 Please note, if you use the 'admin' user name you can manage all aspects of this device. However, if you use the 'user' user name, you are restricted to the areas that you can manage. 

 If you wish to change the default password settings, click the "Administrator Settings" link from the homepage, enter 'admin' for the username and specify the admin password. 

```


### 対応
　プリンタを出荷時の状態に戻し，プリンタの各種設定を，セキュアにした．













# 実行結果

```

===============================================================================
Run time for packet processing was 191.30701 seconds
Snort processed 1936 packets.
Snort ran for 0 days 0 hours 3 minutes 11 seconds
   Pkts/min:          645
   Pkts/sec:           10
===============================================================================
Memory usage summary:
  Total non-mmapped bytes (arena):       433606656
  Bytes in mapped regions (hblkhd):      22908928
  Total allocated space (uordblks):      146021632
  Total free space (fordblks):           287585024
  Topmost releasable block (keepcost):   128
===============================================================================
Packet I/O Totals:
   Received:         1939
   Analyzed:         1936 ( 99.845%)
    Dropped:            0 (  0.000%)
   Filtered:            0 (  0.000%)
Outstanding:            3 (  0.155%)
   Injected:            0
===============================================================================
Breakdown by protocol (includes rebuilt packets):
        Eth:         1941 (100.000%)
       VLAN:            0 (  0.000%)
        IP4:          785 ( 40.443%)
       Frag:            0 (  0.000%)
       ICMP:            1 (  0.052%)
        UDP:          592 ( 30.500%)
        TCP:          192 (  9.892%)
        IP6:          162 (  8.346%)
    IP6 Ext:          167 (  8.604%)
   IP6 Opts:            5 (  0.258%)
      Frag6:            0 (  0.000%)
      ICMP6:           19 (  0.979%)
       UDP6:          116 (  5.976%)
       TCP6:           27 (  1.391%)
     Teredo:            0 (  0.000%)
    ICMP-IP:            0 (  0.000%)
    IP4/IP4:            0 (  0.000%)
    IP4/IP6:            0 (  0.000%)
    IP6/IP4:            0 (  0.000%)
    IP6/IP6:            0 (  0.000%)
        GRE:            0 (  0.000%)
    GRE Eth:            0 (  0.000%)
   GRE VLAN:            0 (  0.000%)
    GRE IP4:            0 (  0.000%)
    GRE IP6:            0 (  0.000%)
GRE IP6 Ext:            0 (  0.000%)
   GRE PPTP:            0 (  0.000%)
    GRE ARP:            0 (  0.000%)
    GRE IPX:            0 (  0.000%)
   GRE Loop:            0 (  0.000%)
       MPLS:            0 (  0.000%)
        ARP:          148 (  7.625%)
        IPX:            0 (  0.000%)
   Eth Loop:           19 (  0.979%)
   Eth Disc:            0 (  0.000%)
   IP4 Disc:            0 (  0.000%)
   IP6 Disc:            0 (  0.000%)
   TCP Disc:            0 (  0.000%)
   UDP Disc:            0 (  0.000%)
  ICMP Disc:            0 (  0.000%)
All Discard:            0 (  0.000%)
      Other:          827 ( 42.607%)
Bad Chk Sum:            0 (  0.000%)
    Bad TTL:            0 (  0.000%)
     S5 G 1:            3 (  0.155%)
     S5 G 2:            2 (  0.103%)
      Total:         1941
===============================================================================
Action Stats:
     Alerts:           20 (  1.030%)
     Logged:           20 (  1.030%)
     Passed:            0 (  0.000%)
Limits:
      Match:            0
      Queue:            0
        Log:            0
      Event:            0
      Alert:            0
Verdicts:
      Allow:         1936 ( 99.845%)
      Block:            0 (  0.000%)
    Replace:            0 (  0.000%)
  Whitelist:            0 (  0.000%)
  Blacklist:            0 (  0.000%)
     Ignore:            0 (  0.000%)
      Retry:            0 (  0.000%)
===============================================================================
Frag3 statistics:
        Total Fragments: 0
      Frags Reassembled: 0
               Discards: 0
          Memory Faults: 0
               Timeouts: 0
               Overlaps: 0
              Anomalies: 0
                 Alerts: 0
                  Drops: 0
     FragTrackers Added: 0
    FragTrackers Dumped: 0
FragTrackers Auto Freed: 0
    Frag Nodes Inserted: 0
     Frag Nodes Deleted: 0

　===============================================================================

===============================================================================
Stream statistics:
            Total sessions: 210
              TCP sessions: 6
              UDP sessions: 204
             ICMP sessions: 0
               IP sessions: 0
                TCP Prunes: 0
                UDP Prunes: 0
               ICMP Prunes: 0
                 IP Prunes: 0
TCP StreamTrackers Created: 6
TCP StreamTrackers Deleted: 6
              TCP Timeouts: 0
              TCP Overlaps: 0
       TCP Segments Queued: 98
     TCP Segments Released: 98
       TCP Rebuilt Packets: 33
         TCP Segments Used: 96
              TCP Discards: 0
                  TCP Gaps: 0
      UDP Sessions Created: 204
      UDP Sessions Deleted: 204
              UDP Timeouts: 0
              UDP Discards: 0
                    Events: 8
           Internal Events: 0
           TCP Port Filter
                  Filtered: 0
                 Inspected: 0
                   Tracked: 214
           UDP Port Filter
                  Filtered: 0
                 Inspected: 0
                   Tracked: 204

===============================================================================

===============================================================================
SMTP Preprocessor Statistics
  Total sessions                                    : 0
  Max concurrent sessions                           : 0
===============================================================================
dcerpc2 Preprocessor Statistics
  Total sessions: 0
===============================================================================
SSL Preprocessor:
   SSL packets decoded: 1         
          Client Hello: 0         
          Server Hello: 0         
           Certificate: 0         
           Server Done: 0         
   Client Key Exchange: 0         
   Server Key Exchange: 0         
         Change Cipher: 0         
              Finished: 0         
    Client Application: 0         
    Server Application: 0         
                 Alert: 1         
  Unrecognized records: 0         
  Completed handshakes: 0         
        Bad handshakes: 0         
      Sessions ignored: 0         
    Detection disabled: 0         
===============================================================================
SIP Preprocessor Statistics
  Total sessions: 0
===============================================================================
Reputation Preprocessor Statistics
  Total Memory Allocated: 0
===============================================================================
Snort exiting

```

# 実行結果2

```
===============================================================================
Run time for packet processing was 167.24434 seconds
Snort processed 1651 packets.
Snort ran for 0 days 0 hours 2 minutes 47 seconds
   Pkts/min:          825
   Pkts/sec:            9
===============================================================================
Memory usage summary:
  Total non-mmapped bytes (arena):       433590272
  Bytes in mapped regions (hblkhd):      22908928
  Total allocated space (uordblks):      146023808
  Total free space (fordblks):           287566464
  Topmost releasable block (keepcost):   128
===============================================================================
Packet I/O Totals:
   Received:         1652
   Analyzed:         1651 ( 99.939%)
    Dropped:            0 (  0.000%)
   Filtered:            0 (  0.000%)
Outstanding:            1 (  0.061%)
   Injected:            0
===============================================================================
Breakdown by protocol (includes rebuilt packets):
        Eth:         1655 (100.000%)
       VLAN:            0 (  0.000%)
        IP4:          612 ( 36.979%)
       Frag:            0 (  0.000%)
       ICMP:            2 (  0.121%)
        UDP:          448 ( 27.069%)
        TCP:          162 (  9.789%)
        IP6:          124 (  7.492%)
    IP6 Ext:          124 (  7.492%)
   IP6 Opts:            0 (  0.000%)
      Frag6:            0 (  0.000%)
      ICMP6:           43 (  2.598%)
       UDP6:           79 (  4.773%)
       TCP6:            0 (  0.000%)
     Teredo:            2 (  0.121%)
    ICMP-IP:            0 (  0.000%)
    IP4/IP4:            0 (  0.000%)
    IP4/IP6:            0 (  0.000%)
    IP6/IP4:            0 (  0.000%)
    IP6/IP6:            0 (  0.000%)
        GRE:            0 (  0.000%)
    GRE Eth:            0 (  0.000%)
   GRE VLAN:            0 (  0.000%)
    GRE IP4:            0 (  0.000%)
    GRE IP6:            0 (  0.000%)
GRE IP6 Ext:            0 (  0.000%)
   GRE PPTP:            0 (  0.000%)
    GRE ARP:            0 (  0.000%)
    GRE IPX:            0 (  0.000%)
   GRE Loop:            0 (  0.000%)
       MPLS:            0 (  0.000%)
        ARP:          185 ( 11.178%)
        IPX:            0 (  0.000%)
   Eth Loop:           17 (  1.027%)
   Eth Disc:            0 (  0.000%)
   IP4 Disc:            0 (  0.000%)
   IP6 Disc:            0 (  0.000%)
   TCP Disc:            0 (  0.000%)
   UDP Disc:            0 (  0.000%)
  ICMP Disc:            0 (  0.000%)
All Discard:            0 (  0.000%)
      Other:          719 ( 43.444%)
Bad Chk Sum:            0 (  0.000%)
    Bad TTL:            0 (  0.000%)
     S5 G 1:            2 (  0.121%)
     S5 G 2:            2 (  0.121%)
      Total:         1655
===============================================================================
Action Stats:
     Alerts:           45 (  2.719%)
     Logged:           45 (  2.719%)
     Passed:            0 (  0.000%)
Limits:
      Match:            0
      Queue:            0
        Log:            0
      Event:            0
      Alert:            0
Verdicts:
      Allow:         1576 ( 95.400%)
      Block:            0 (  0.000%)
    Replace:            0 (  0.000%)
  Whitelist:           75 (  4.540%)
  Blacklist:            0 (  0.000%)
     Ignore:            0 (  0.000%)
      Retry:            0 (  0.000%)
===============================================================================
Frag3 statistics:
        Total Fragments: 0
      Frags Reassembled: 0
               Discards: 0
          Memory Faults: 0
               Timeouts: 0
               Overlaps: 0
              Anomalies: 0
                 Alerts: 0
                  Drops: 0
     FragTrackers Added: 0
    FragTrackers Dumped: 0
FragTrackers Auto Freed: 0
    Frag Nodes Inserted: 0
     Frag Nodes Deleted: 0
===============================================================================
===============================================================================
Stream statistics:
            Total sessions: 167
              TCP sessions: 12
              UDP sessions: 155
             ICMP sessions: 0
               IP sessions: 0
                TCP Prunes: 0
                UDP Prunes: 0
               ICMP Prunes: 0
                 IP Prunes: 0
TCP StreamTrackers Created: 12
TCP StreamTrackers Deleted: 12
              TCP Timeouts: 0
              TCP Overlaps: 0
       TCP Segments Queued: 50
     TCP Segments Released: 50
       TCP Rebuilt Packets: 13
         TCP Segments Used: 40
              TCP Discards: 0
                  TCP Gaps: 0
      UDP Sessions Created: 155
      UDP Sessions Deleted: 155
              UDP Timeouts: 0
              UDP Discards: 0
                    Events: 0
           Internal Events: 0
           TCP Port Filter
                  Filtered: 0
                 Inspected: 0
                   Tracked: 158
           UDP Port Filter
                  Filtered: 0
                 Inspected: 0
                   Tracked: 155
===============================================================================
===============================================================================
SMTP Preprocessor Statistics
  Total sessions                                    : 0
  Max concurrent sessions                           : 0
===============================================================================
dcerpc2 Preprocessor Statistics
  Total sessions: 0
===============================================================================
SSL Preprocessor:
   SSL packets decoded: 9         
          Client Hello: 0         
          Server Hello: 0         
           Certificate: 0         
           Server Done: 0         
   Client Key Exchange: 0         
   Server Key Exchange: 0         
         Change Cipher: 0         
              Finished: 0         
    Client Application: 0         
    Server Application: 9         
                 Alert: 0         
  Unrecognized records: 0         
  Completed handshakes: 0         
        Bad handshakes: 0         
      Sessions ignored: 9         
    Detection disabled: 0         
===============================================================================
SIP Preprocessor Statistics
  Total sessions: 0
===============================================================================
Reputation Preprocessor Statistics
  Total Memory Allocated: 0
===============================================================================
Snort exiting

```

# 実行結果3

```

^C*** Caught Int-Signal
===============================================================================
Run time for packet processing was 1079.202289 seconds
Snort processed 8863 packets.
Snort ran for 0 days 0 hours 17 minutes 59 seconds
   Pkts/min:          521
   Pkts/sec:            8
===============================================================================
Memory usage summary:
  Total non-mmapped bytes (arena):       433713152
  Bytes in mapped regions (hblkhd):      22908928
  Total allocated space (uordblks):      146019184
  Total free space (fordblks):           287693968
  Topmost releasable block (keepcost):   64
===============================================================================
Packet I/O Totals:
   Received:         8863
   Analyzed:         8863 (100.000%)
    Dropped:            0 (  0.000%)
   Filtered:            0 (  0.000%)
Outstanding:            0 (  0.000%)
   Injected:            0
===============================================================================
Breakdown by protocol (includes rebuilt packets):
        Eth:         8880 (100.000%)
       VLAN:            0 (  0.000%)
        IP4:         2486 ( 27.995%)
       Frag:            0 (  0.000%)
       ICMP:            6 (  0.068%)
        UDP:         2319 ( 26.115%)
        TCP:          161 (  1.813%)
        IP6:          810 (  9.122%)
    IP6 Ext:          877 (  9.876%)
   IP6 Opts:           79 (  0.890%)
      Frag6:           24 (  0.270%)
      ICMP6:          188 (  2.117%)
       UDP6:          606 (  6.824%)
       TCP6:            0 (  0.000%)
     Teredo:            4 (  0.045%)
    ICMP-IP:            0 (  0.000%)
    IP4/IP4:            0 (  0.000%)
    IP4/IP6:            0 (  0.000%)
    IP6/IP4:            0 (  0.000%)
    IP6/IP6:            0 (  0.000%)
        GRE:            0 (  0.000%)
    GRE Eth:            0 (  0.000%)
   GRE VLAN:            0 (  0.000%)
    GRE IP4:            0 (  0.000%)
    GRE IP6:            0 (  0.000%)
GRE IP6 Ext:            0 (  0.000%)
   GRE PPTP:            0 (  0.000%)
    GRE ARP:            0 (  0.000%)
    GRE IPX:            0 (  0.000%)
   GRE Loop:            0 (  0.000%)
       MPLS:            0 (  0.000%)
        ARP:          825 (  9.291%)
        IPX:            0 (  0.000%)
   Eth Loop:          107 (  1.205%)
   Eth Disc:            0 (  0.000%)
   IP4 Disc:            0 (  0.000%)
   IP6 Disc:            0 (  0.000%)
   TCP Disc:            0 (  0.000%)
   UDP Disc:            0 (  0.000%)
  ICMP Disc:            0 (  0.000%)
All Discard:            0 (  0.000%)
      Other:         4656 ( 52.432%)
Bad Chk Sum:            0 (  0.000%)
    Bad TTL:            0 (  0.000%)
     S5 G 1:            1 (  0.011%)
     S5 G 2:            4 (  0.045%)
      Total:         8880
===============================================================================
Action Stats:
     Alerts:          194 (  2.185%)
     Logged:          194 (  2.185%)
     Passed:            0 (  0.000%)
Limits:
      Match:            0
      Queue:            0
        Log:            0
      Event:            0
      Alert:            0
Verdicts:
      Allow:         8803 ( 99.323%)
      Block:            0 (  0.000%)
    Replace:            0 (  0.000%)
  Whitelist:           60 (  0.677%)
  Blacklist:            0 (  0.000%)
     Ignore:            0 (  0.000%)
      Retry:            0 (  0.000%)
===============================================================================
Frag3 statistics:
        Total Fragments: 24
      Frags Reassembled: 12
               Discards: 0
          Memory Faults: 0
               Timeouts: 0
               Overlaps: 0
              Anomalies: 0
                 Alerts: 0
                  Drops: 0
     FragTrackers Added: 12
    FragTrackers Dumped: 12
FragTrackers Auto Freed: 0
    Frag Nodes Inserted: 24
     Frag Nodes Deleted: 24
===============================================================================
===============================================================================
Stream statistics:
            Total sessions: 685
              TCP sessions: 6
              UDP sessions: 679
             ICMP sessions: 0
               IP sessions: 0
                TCP Prunes: 0
                UDP Prunes: 0
               ICMP Prunes: 0
                 IP Prunes: 0
TCP StreamTrackers Created: 6
TCP StreamTrackers Deleted: 6
              TCP Timeouts: 0
              TCP Overlaps: 0
       TCP Segments Queued: 13
     TCP Segments Released: 13
       TCP Rebuilt Packets: 5
         TCP Segments Used: 8
              TCP Discards: 0
                  TCP Gaps: 2
      UDP Sessions Created: 679
      UDP Sessions Deleted: 679
              UDP Timeouts: 0
              UDP Discards: 0
                    Events: 117
           Internal Events: 0
           TCP Port Filter
                  Filtered: 0
                 Inspected: 0
                   Tracked: 156
           UDP Port Filter
                  Filtered: 0
                 Inspected: 0
                   Tracked: 679
===============================================================================
HTTP Inspect - encodings (Note: stream-reassembled packets included):
    POST methods:                         2         
    GET methods:                          0         
    HTTP Request Headers extracted:       2         
    HTTP Request Cookies extracted:       0         
    Post parameters extracted:            0         
    HTTP response Headers extracted:      0         
    HTTP Response Cookies extracted:      0         
    Unicode:                              0         
    Double unicode:                       0         
    Non-ASCII representable:              0         
    Directory traversals:                 0         
    Extra slashes ("//"):                 0         
    Self-referencing paths ("./"):        0         
    HTTP Response Gzip packets extracted: 0         
    Gzip Compressed Data Processed:       n/a       
    Gzip Decompressed Data Processed:     n/a       
    Http/2 Rebuilt Packets:               0         
    Total packets processed:              6         
===============================================================================
SMTP Preprocessor Statistics
  Total sessions                                    : 0
  Max concurrent sessions                           : 0
===============================================================================
dcerpc2 Preprocessor Statistics
  Total sessions: 0
===============================================================================
SSL Preprocessor:
   SSL packets decoded: 62        
          Client Hello: 0         
          Server Hello: 0         
           Certificate: 0         
           Server Done: 0         
   Client Key Exchange: 0         
   Server Key Exchange: 0         
         Change Cipher: 0         
              Finished: 0         
    Client Application: 49        
    Server Application: 10        
                 Alert: 17        
  Unrecognized records: 0         
  Completed handshakes: 0         
        Bad handshakes: 0         
      Sessions ignored: 10        
    Detection disabled: 50        
===============================================================================
SIP Preprocessor Statistics
  Total sessions: 0
===============================================================================
Reputation Preprocessor Statistics
  Total Memory Allocated: 0
===============================================================================
Snort exiting
```


# logの見方

http://jem.es.land.to/security/snortlog.htm

Snortのログ

　snortは不正パケットが流れてくると、シグネチャとパターンマッチングを行い、マッチするパケットをalertファイルにログを書き出します。

　例を挙げると下記のようなログが表示されます。
[**] ①[1:1256:7] ②WEB-IIS CodeRed v2 root.exe access [**]
③[Classification: Web Application Attack] ④[Priority: 1]
⑤09/29-03:14:50.709695 0:0:0:9:9:9 -> 0:0:0:9:9:A ⑥type:0x800 ⑦len:0x7C
⑧110.110.110.110:3202 -> 192.0.0.0:80 ⑨TCP TTL:49 ⑩TOS:0x0 ⑪ID:10758 ⑫IpLen:20
⑬DgmLen:110 ⑭DF
⑮***AP*** ⑯Seq: 0xCC9A9C01  Ack: 0xD02C9F16  ⑰Win: 0x4410  ⑱TcpLen: 20
[Xref => http://www.cert.org/advisories/CA-2001-19.html]

[**] [1:1002:5] WEB-IIS cmd.exe access [**]
[Classification: Web Application Attack] [Priority: 1]
09/29-03:14:52.869792 0:0:0:9:9:9 -> 0:0:0:9:9:A type:0x800 len:0xAB
110.110.110.110:3268 -> 192.0.0.0:80 TCP TTL:49 TOS:0x0 ID:10935 IpLen:20
DgmLen:157 DF
***AP*** Seq: 0xCCD4E38F  Ack: 0xD03930B1  Win: 0x4410  TcpLen: 2

## logファイルの場所
[root@d-lab2]/var/log/snort# find / -type f -name "local.rules"
/home/n-lab/snort/rules/local.rules ##これは空
/etc/snort/rules/local.rules


## snortによる実験の考察
　snortにより学科のパケットをキャプチャすることによって，異常なパケットを送るプリンタを発見することができた.snortは異常なパケットのパターンを公式サイトからダウンロードしルールセットとして適応することで，自動化できる部分がある．今回は，帯域が少ないので取りこぼしてしまうパケットが多い中，注意深く見てみることで異常なパケットを発見することができ，運が良かったといえる．


## 実験の意義
nmap,wireshark,snortと一連のネットワークセキュリティの脆弱性を探すツールを学んだことで，自衛の術を学ぶことができた．


# snortの参考文献
https://fisproject.jp/2015/08/http2-packets-capture-with-wireshark/
http://www.yk.rim.or.jp/~shikap/security/awacs/snort-faq-J.html
