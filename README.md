# IPFS 教學和筆記

因為 IPFS 的繁中資料實在太少了，決定邊學習邊筆記。

目前我還不會把 git 和 IPFS 連在一起用，所以邊修改筆記、邊 publish 到 IPFS 上。

# 為什麼要使用 IPFS

IPFS (星際檔案系統) 是用來取代已經太過集中化的 HTTP 的一種方案，這裡不做一般性的介紹，因為其它 blog / Wikipedia 上都有寫了。我想使用 IPFS 的理由是:
1. 網路過度集中化，使用者自願放棄自由，請參考 [網際網路已經完蛋了](https://www.inside.com.tw/2017/08/07/internet-is-too-centralized)
2. 依賴單一公司提供的平台所發佈的文章，即使沒有反政府、侵權、政治不正確 blah blah 還是有各種不同的可能被下架，而你已經在 EULA 中同意不去追究了。
3. Google Blogspot, Tumblr, Facebook Blog 提供的免費、高品質 blog，仍然有上述的疑慮。
4. 即使是自己架的 Word Press，哪一天被警察用任何理由抄掉了，上面的網頁就沒有了。

去中心化，才能有民主、自由的網路。即使如此，去中心化仍然需要網路中立性的支持，不然你的 ISP 仍然可以獨厚(加速)大公司的網站。

本篇教學 **不會** 論述以下主題：
- 免責或匿名性。這是另一個大題目，去中心化不代表你可以匿名。
- 挖礦、區塊鏈、或任何虛擬貨幣。

# 下載、安裝

下載很簡單，請直接到 [IPFS 官網](https://ipfs.io/) 或直接 [點這裡下載](https://dist.ipfs.io/#go-ipfs)。我直接下載了 go-ipfs 0.4.10, Mac OS X 請下載 Darwin amd64, Ubuntu 請下載 Linux amd64。

## 安裝

直接在命令列下打這些指令就好:
```
$ ipfs init     # 會在 ~/.ipfs 開一個目錄，存放區塊檔，預設是最大 10GB

$ ipfs id       # 列出自己的 ID, 但其實不需要太介意
{
	"ID": "QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR",
	"PublicKey": "...",
	"Addresses": [
		"..."
	],
	"AgentVersion": "go-ipfs/0.4.10/",
	"ProtocolVersion": "ipfs/0.1.0"
}
```

想修改預設的暫存大小的話，請下這個指令:
```bash
export EDITOR=/usr/bin/vim
ipfs config edit
```
找到 `"StorageMax": "10GB",` 這行，把 10GB 換成你要的大小即可。

# 新增第一個檔案

先來隨便新增一個檔案吧。打開記事本，隨便打幾行字 `lorem ipsum dolor sit amet` 存成 `README.md`。

`ipfs add` 可以把檔案加進 IPFS 裡，它會傳回一組 HASH, 那個 HASH 就是這個檔案的唯一識別代碼了。
```
$ ipfs add README.md
added QmQhK6KAVA2nJgFYzf7D1yHdH11GiGJv6zRTUhoVZwXpDd README.md

$ ipfs cat /ipfs/QmQhK6KAVA2nJgFYzf7D1yHdH11GiGJv6zRTUhoVZwXpDd
lorem ipsum dolor sit amet
```
即使你換到別台機器，一樣可以用 `ipfs cat /ipfs/QmQh...XpDd` 看到這個檔案的內容。

# 我比較習慣目錄

大家都還是比較習慣目錄結構吧？已經 `ipfs add` 的檔案，可以被放進目錄裡。
```
$ ipfs files mkdir /SmartCity   # 開一個目錄
$ ipfs files cp /ipfs/QmQhK6KAVA2nJgFYzf7D1yHdH11GiGJv6zRTUhoVZwXpDd /SmartCity/README.md
$ ipfs files ls /
SmartCity
$ ipfs files ls /SmartCity/
README.md
$ ipfs files read /SmartCity/README.md
lorem ipsum dolor sit amet
```
我目前還不知道怎麼把目錄 export 出去，讓別人也可用使用同樣的目錄結構。

# 我在 IPFS 上的第一個網頁

# 怎樣和硬碟上的資料保持同步？

# 我還不懂的部份

- BitSwap
- DHT

# 參考資料

- https://blog.acolyer.org/2015/10/05/ipfs-content-addressed-versioned-p2p-file-system
- https://discuss.ipfs.io/t/how-does-files-api-ipfs-files-command-work/344/3

# License 版權聲明

我自己編寫的部份，全部使用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh_TW) 聲明。如果有引用他人的部份，請參考各該文件所屬的版權聲明。
