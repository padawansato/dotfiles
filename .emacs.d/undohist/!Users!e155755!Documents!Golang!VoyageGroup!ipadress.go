
((digest . "8b9b63d59e96b24598f06dceb86c355c") (undo-list nil (nil rear-nonsticky nil 884 . 885) (nil fontified nil 1 . 885) (1 . 885) nil ("package main

import (
	\"fmt\"
	\"net\"
)

//Class   Starting IPAddress     Ending IP Address    # of Hosts
//A       10.0.0.0               10.255.255.255       16,777,216
//B       172.16.0.0             172.31.255.255       1,048,576
//C       192.168.0.0            192.168.255.255      65,536
//Link-local  169.254.0.0            169.254.255.255      65,536
//Local       127.0.0.0              127.255.255.255      16777216

func IsPublicIP(IP net.IP) bool {
	if IP.IsLoopback() || IP.IsLinkLocalMulticast() || IP.IsLinkLocalUnicast() {
		return false
	}
	if ip4 := IP.To4(); ip4 != nil {
		switch {
		case ip4[0] == 10:
			return false
		case ip4[0] == 172 && ip4[1] >= 16 && ip4[1] <= 31:
			return false
		case ip4[0] == 192 && ip4[1] == 168:
			return false
		default:
			return true
		}
	}
	return false
}

func main() {
	var ips = []string{\"192.168.0.5\", \"106.51.36.237\", \"127.0.0.1\", \"172.16.25.0\", \"10.10.25.43\"}
	for _, ip := range ips {
		IP := net.ParseIP(ip)
		fmt.Println(IP, \":\", IsPublicIP(IP))
	}
}
" . 1) ((marker . 1) . -1018) ((marker) . -39) ((marker) . -39) ((marker) . -30) ((marker) . -30) ((marker) . -23) ((marker) . -23) ((marker) . -14) ((marker) . -14) ((marker) . -13) ((marker) . -13) ((marker) . -462) ((marker) . -462) ((marker) . -540) ((marker) . -540) ((marker) . -555) ((marker) . -555) ((marker) . -558) ((marker) . -558) ((marker) . -592) ((marker) . -592) ((marker) . -603) ((marker) . -603) ((marker) . -624) ((marker) . -624) ((marker) . -640) ((marker) . -640) ((marker) . -694) ((marker) . -694) ((marker) . -710) ((marker) . -710) ((marker) . -428) ((marker) . -428) ((marker) . -427) ((marker) . -427) ((marker) . -360) ((marker) . -360) ((marker) . -295) ((marker) . -295) ((marker) . -234) ((marker) . -234) ((marker) . -170) ((marker) . -170) ((marker) . -105) ((marker) . -105) ((marker) . -40) ((marker) . -40) ((marker . 1) . -949) ((marker) . -37) ((marker) . -37) ((marker . 1) . -131) ((marker . 1) . -131) ((marker . 1) . -1018) ((marker . 1) . -848) ((marker . 1) . -848) ((marker . 1) . -1018) ((marker . 1) . -1018) ((marker . 2) . -1018) ((marker . 1) . -848) ((marker . 2) . -849) ((marker) . -1018) ((marker) . -1018) ((marker) . -949) ((marker) . -950) ((marker) . -131) ((marker) . -132) ((marker) . -1018) ((marker) . -749) ((marker) . -749) ((marker) . -765) ((marker) . -765) ((marker) . -776) ((marker) . -776) ((marker) . -791) ((marker) . -791) ((marker) . -795) ((marker) . -795) ((marker) . -798) ((marker) . -798) ((marker) . -812) ((marker) . -812) ((marker) . -814) ((marker) . -814) (t 23960 12579 926074 340000) nil (nil rear-nonsticky nil 1018 . 1019) (nil fontified nil 1 . 1019) (1 . 1019) nil ("package main

import (
	\"fmt\"
	\"net\"
)

//Class   Starting IPAddress     Ending IP Address    # of Hosts
//A       10.0.0.0               10.255.255.255       16,777,216
//B       172.16.0.0             172.31.255.255       1,048,576
//C       192.168.0.0            192.168.255.255      65,536
//Link-local  169.254.0.0            169.254.255.255      65,536
//Local       127.0.0.0              127.255.255.255      16777216

func IsPublicIP(IP net.IP) bool {
	if IP.IsLoopback() || IP.IsLinkLocalMulticast() || IP.IsLinkLocalUnicast() {
		return false
	}
	if ip4 := IP.To4(); ip4 != nil {
		switch {
		case ip4[0] == 10:
			return false
		case ip4[0] == 172 && ip4[1] >= 16 && ip4[1] <= 31:
			return false
		case ip4[0] == 192 && ip4[1] == 168:
			return false
		default:
			return true
		}
	}
	return false
}

func main() {
	var ips = []string{\"192.168.0.5\", \"106.51.36.237\", \"127.0.0.1\", \"172.16.25.0\", \"10.10.25.43\"}
	for _, ip := range ips {
		IP := net.ParseIP(ip)
		fmt.Println(IP, \":\", IsPublicIP(IP))
	}
}
package main

/**

Hard:自分のマシンのIPアドレスを取得し画面表示
自分のマシンのIPアドレス”のみ”を表示する
ただし、ループバックインタフェースのIPアドレス(127.0.0.1)は除外して表示する
※もし余裕があれば、WindowsとMacOSXとLinuxに対応したソースコードを書いてみてください。余裕があれば。

**/

// MacOSX, Linuxで動作するソースコード

import (
	\"fmt\"
	\"net\"
	\"os\"
)

func main() {
}
f" . 1) ((marker . 1) . -1276) ((marker . 1) . -1273) ((marker . 1) . -1273) ((marker . 1) . -1273) ((marker . 1) . -1273) ((marker . 1) . -1276) ((marker . 2) . -1276) ((marker . 1) . -1018) ((marker . 2) . -1019) ((marker) . -1276) ((marker) . -1276) ((marker) . -1275) ((marker) . -1276) ((marker) . -1273) ((marker) . -1274) ((marker) . -1276) nil (nil rear-nonsticky nil 1018 . 1019) (nil fontified nil 1 . 1019) (1 . 1019) nil (nil rear-nonsticky nil 258 . 259) (nil fontified nil 258 . 259) (258 . 259) nil (257 . 258) nil (256 . 257) ("}" . -256) (256 . 257) nil ("_" . -256) ((marker . 885) . -1) ((marker . 2) . -1) ((marker) . -1) ((marker) . -1) ((marker) . -1) ((marker) . -1) 257 nil (256 . 257) nil ("	addrs, err := net.InterfaceAddrs()
	fmt.Println(addrs)

	fmt.Println(\"-------------------------------------------------\")

	for _, addrs := range addrs {
		fmt.Println(addrs.String())
	}

	fmt.Println(\"-------------------------------------------------\")
	if err != nil {
		os.Stderr.WriteString(\"Oops: \" + err.Error() + \"\\n\")
		os.Exit(1)
	}

	for _, a := range addrs {
		if ipnet, ok := a.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
			if ipnet.IP.To4() != nil {
				fmt.Println(ipnet.IP.String())
			}
		}
	}

}
package main

/**

Hard:自分のマシンのIPアドレスを取得し画面表示
自分のマシンのIPアドレス”のみ”を表示する
ただし、ループバックインタフェースのIPアドレス(127.0.0.1)は除外して表示する
※もし余裕があれば、WindowsとMacOSXとLinuxに対応したソースコードを書いてみてください。余裕があれば。

**/

// MacOSX, Linuxで動作するソースコード

import (
  \"net\"
  \"os\"
  \"fmt\"
)
 
func main() {
  addrs, err := net.InterfaceAddrs()
  fmt.Println(addrs)

  fmt.Println(\"-------------------------------------------------\")

  for _, addrs := range addrs {
    fmt.Println(addrs.String())
  }  

  fmt.Println(\"-------------------------------------------------\")
  if err != nil {
    os.Stderr.WriteString(\"Oops: \" + err.Error() + \"\\n\")
  os.Exit(1)
  }
 
  for _, a := range addrs {
    if ipnet, ok := a.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
      if ipnet.IP.To4() != nil {
        fmt.Println(ipnet.IP.String())
      }
    }
  }

}package main

import (
	\"errors\"
	\"fmt\"
	\"net\"
)


func IsPublicIP(IP net.IP) bool {
    if IP.IsLoopback() || IP.IsLinkLocalMulticast() || IP.IsLinkLocalUnicast() {
        return false
    }
    if ip4 := IP.To4(); ip4 != nil {
        switch {
        case ip4[0] == 10:
            return false
        case ip4[0] == 172 && ip4[1] >= 16 && ip4[1] <= 31:
            return false
        case ip4[0] == 192 && ip4[1] == 168:
            return false
        default:
            return true
        }
    }
    return false" . 256) ((marker . 1) . -1848) ((marker . 1) . -1848) ((marker . 1) . -1848) ((marker . 1) . -1848) ((marker . 1) . -1848) ((marker) . -1848) ((marker . 1) . -1848) ((marker . 2) . -1848) ((marker) . -1405) ((marker) . -1406) ((marker) . -1372) ((marker) . -1373) ((marker) . -1848) ((marker) . -1848) nil undo-tree-canary))
