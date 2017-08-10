# IPFS 教學和筆記

因為 IPFS 的繁中資料實在太少了，決定邊學習邊筆記。

本篇教學的網址是:

- (gitpage) https://miaoski.github.io/ipfs-tutorial/
- (IPFS) /ipns/miaoski.idv.tw/
- (IPFS Gateway) https://ipfs.io/ipns/miaoski.idv.tw/

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
- ICO 特別是 IPFS 最近的 Filecoin ICO 。

完整的介紹性文章，可以參考 InfoQ 的 [IPFS：替代HTTP的分布式网络协议](http://www.infoq.com/cn/articles/ipfs) 。

# 下載、安裝

## 下載

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

# 新增檔案

先來隨便新增一個檔案吧。打開記事本，隨便打幾行字 `lorem ipsum dolor sit amet` 存成 `README.md`。

`ipfs add` 可以把檔案加進 IPFS 裡，它會傳回一組 HASH, 那個 HASH 就是這個檔案的唯一識別代碼了。

```
$ ipfs add README.md
added QmQhK6KAVA2nJgFYzf7D1yHdH11GiGJv6zRTUhoVZwXpDd README.md

$ ipfs cat /ipfs/QmQhK6KAVA2nJgFYzf7D1yHdH11GiGJv6zRTUhoVZwXpDd
lorem ipsum dolor sit amet
```

即使你換到別台機器，一樣可以用 `ipfs cat /ipfs/QmQhK6KAVA2nJgFYzf7D1yHdH11GiGJv6zRTUhoVZwXpDd` 看到這個檔案的內容。

如果要分享給沒有安裝 IPFS 的朋友(建議順便推坑!) 可以請他使用 IPFS Gateway: https://ipfs.io/ipfs/QmQhK6KAVA2nJgFYzf7D1yHdH11GiGJv6zRTUhoVZwXpDd 把後面的 HASH 換成你剛剛新增的檔案的 HASH，就可以了!

## 我比較習慣目錄

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

## 上傳一整個目錄

使用 `ipfs add -r` 可以上傳一整個目錄。比方說，這篇教學可以用這種方式上傳 (**小心** 不要把 .git/ 下面的東西都傳上去了!)

```
$ ipfs add -r ipfs-tutorial-taiwan-mandarin
added QmdpYD8hejksA5SHNdRfDzE2EYzpSkbazyVAJq5hRwbKtp ipfs-tutorial-taiwan-mandarin/README.md
added QmWe7m2K8DThCUTPuw5KcbYvpAwogScXt8gazfG7QiRpSo ipfs-tutorial-taiwan-mandarin
```

這樣就可以用下列方式取得 `README.md` 的內容:

1. ipfs cat /ipfs/QmdpYD8hejksA5SHNdRfDzE2EYzpSkbazyVAJq5hRwbKtp
2. ipfs cat /ipfs/QmWe7m2K8DThCUTPuw5KcbYvpAwogScXt8gazfG7QiRpSo/README.md

# 我在 IPFS 上的第一個網頁

IPFS 的本質是分散式的檔案系統，如果只是要 host 分散式的部落格的話，可以使用 [ZeroNet](https://zeronet.io/) 。晚一點我會再寫一篇 ZeroNet 的介紹。

**請注意** 如果在 `pin` 或 `publish` 的過程中遇到任何問題，可能是防火牆的關係。跑 `ipfs daemon` 的時候，它會列出對外連線的 port 請在防火牆打開。

```
% ipfs daemon
Initializing daemon...
Adjusting current ulimit to 2048...
Successfully raised file descriptor limit to 2048.
Swarm listening on /ip4/127.0.0.1/tcp/4001
Swarm listening on /ip4/192.168.2.1/tcp/4001
Swarm listening on /ip4/220.xxx.xx.xxx/tcp/4001 ← 這個!!
Swarm listening on /ip6/::1/tcp/4001
API server listening on /ip4/127.0.0.1/tcp/5001
Gateway (readonly) server listening on /ip4/127.0.0.1/tcp/8080
Daemon is ready
```

Debian 系的 Linux 請愛用 `sudo ufw allow 4001` 即可。

出於莫名的原因，我決定不要使用最常見的 Jekyll 。以下範例是 Hugo 做的 :)

Huge 後面還有使用 ipfs 範例中的 mdown 來 render 的例子。

## 安裝 Hugo

參考 [Hugo官網](http://gohugo.io/getting-started/quick-start/) 的說明，在 Mac 上安裝 Hugo:

```
$ brew install hugo
Updating Homebrew...
Warning: hugo 0.26 is already installed
$ hugo version
Hugo Static Site Generator v0.26 darwin/amd64 BuildDate: 2017-08-08T14:55:38+08:00
$ hugo new site ipfs-tutorial-zh-TW
Congratulations! Your new Hugo site is created in /Users/miaoski/github/ipfs-tutorial-zh-TW.
$ git init
Initialized empty Git repository in /Users/miaoski/github/ipfs-tutorial-zh-TW/.git/
$ git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
Cloning into '/Users/miaoski/github/ipfs-tutorial-zh-TW/themes/ananke'...
$ echo 'theme = "ananke"' >> config.toml
```

修改 `config.toml` 設定一下 title 和語系什麼的，就可以了。

### 新增 blog 文章

```
$ hugo new posts/ipfs-tutorial.md
/Users/miaoski/github/ipfs-tutorial-zh-TW/content/posts/ipfs-tutorial.md created
$ cat ../ipfs-tutorial/README.md >> ./content/posts/ipfs-tutorial.md
```

修改一下，把 `draft: true` 改成 `draft: false` 再執行一次 `hugo` 就可以 render 出網頁了。

### 把部落格新增到 IPFS 上

依據 hugo 的建議，先 `rm -fr public/` 再重新執行 `hugo` 比較好...

```bash
$ rm -fr ./public/
$ hugo
$ ipfs add -r ./public/
added QmW7dJkAjtLgUtJcgUrTPC2jSLTD8uS4bfzPPXYdsZGhFN public/posts
added QmecA1oy5du9TwNrJrwxjq5emUdG7jbukv8Pzuo2q8CjRc public/tags
added QmT7TX5vGmFz86V8cDkPuTss1vp4qTXeaziGZrjdJhURFf public
```

請跳到 IPNS 一節閱讀。

## mdown

mdown 是 ipfs 範例中的 [markdown-viewer](https://github.com/ipfs/examples/tree/master/webapps/markdown-viewer) 是以 MIT 版權宣告的。有時候我們只是想分享一份簡單的 markdown，它十分輕量，render 出來的效果也不錯。它的背後是 StrapDownJS。

本文的 [Github repo](https://github.com/miaoski/ipfs-tutorial) 已經把 mdown 加在裡面了，直接 `make` 就會看到 `ipfs add` 上去的 HASH。它也會寫在 `published-version` 檔案裡。接著我們可以用 IPNS 發佈它。

## IPNS

拿到網站的 HASH 後，建議註冊 **IPNS** ，因為每次更新部落格的內容，上面的 HASH 都會變，我們需要一個固定的 ID 指向最新的 HASH 。以本文為例：

```bash
$ ipfs name publish QmT7TX5vGmFz86V8cDkPuTss1vp4qTXeaziGZrjdJhURFf
Published to QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR: /ipfs/QmT7TX5vGmFz86V8cDkPuTss1vp4qTXeaziGZrjdJhURFf 
$ ipfs name resolve QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR
/ipfs/QmT7TX5vGmFz86V8cDkPuTss1vp4qTXeaziGZrjdJhURFf
```

以後每次更新完網站，都要重新 `ipfs add -r ./public/` 一 次，然後再執行 `ipfs name publish ...` ，這樣`/ipns/QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR` 才會指向最新的 HASH 哦! (注意是 **IPNS** 不要搞錯!)

使用 hugo 的同學，順便更新 `config.toml`:

```
baseURL = "https://ipfs.io/ipns/QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR/"
languageCode = "zh-tw"
title = "第一次用 IPFS 就上手"
theme = "ananke"
```

# 快取 (pin)

把內容快取到本地端，並且提供給其他人。

```
ipfs pin add QmT7TX5vGmFz86V8cDkPuTss1vp4qTXeaziGZrjdJhURFf
```

`add` 本身就是遞歸的，所有的子目錄都會被 pin 住。可以用 `ipfs pin ls` 看看本地端 pin 了什麼。 [這一篇](https://ipfs.io/ipfs/QmNZiPk974vDsPmQii3YbrMKfi12KTSNM7XMiYyiea4VYZ/example#/ipfs/QmP8WUPq2braGQ8iZjJ6w9di6mzgoTWyRLayrMRjjDoyGr/pinning/readme.md) 的指令都可以玩玩看。

# TXT

因為一串 HASH 真的很難記，所以可以用修改 DNS 的 TXT 欄的方式，讓使用者可以用 https://ipfs.io/ipns/miaoski.idv.tw/ 這種方式，存取到你的檔案或部落格。要特別注意， TXT 設定完後，如果你用筆電的話，不要太快離線，不然別人可能還來不及 cache 住 TXT 解析的內容。

```
$ host -t TXT miaoski.idv.tw
miaoski.idv.tw descriptive text "dnslink=/ipns/QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR"
```

下面的情況都是正常的。但是 `ipfs name resolve -r` 必須要能正確解析出 /ipfs/ 的位址，別人才看得到你公開的內容。
```
$ ipfs name resolve miaoski.idv.tw
Error: Could not resolve name (recursion limit exceeded).

$ ipfs dns -r atnnn.com
Error: not a valid domain name

$ ipfs dns atnnn.com
Error: Could not resolve name (recursion limit exceeded).
```

來試試看我的網頁吧! https://ipfs.io/ipns/miaoski.idv.tw/

# 我還不懂的部份

- BitSwap
- DHT
- 把 git repo 和 IPFS 整合在一起

# 參考資料

- https://blog.acolyer.org/2015/10/05/ipfs-content-addressed-versioned-p2p-file-system
- https://discuss.ipfs.io/t/how-does-files-api-ipfs-files-command-work/344/3
- https://ipfs.io/ipfs/QmdPtC3T7Kcu9iJg6hYzLBWR5XCDcYMY7HV685E3kH3EcS/2015/09/15/hosting-a-website-on-ipfs/
- https://qtum.org/zh/blog/ru-he-shi-yong-xing-ji-wen-jian-chuan-shu-wang-luo-ipfs-da-jian-qu-kuai-lian-fu-wu

# License 版權聲明

我自己編寫的部份，全部使用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh_TW) 聲明。如果有引用他人的部份，請參考各該文件所屬的版權聲明。
