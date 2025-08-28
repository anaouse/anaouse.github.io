---
title: shixian5
date: 2025-07-29
author: anaouse
layout: doc
---

## クズが聖剣拾った結果

learn japanese words and grammar by reading novel sentence:

page 11

| ----------- | ----------- |-----------|-----------|
|プロローグ-puroro-gu, prologue|地球-chikyu, earth|全く-mattaku, completely|別の-betunino, different|
|時空-jiku, space-time|あとる-atoru, certain|だろう-darou, probably|五階建て-gokaidate, 5 story building|
|庁舎-chousha, office building|正面-shoume, front|裏手-urate, back, near|設ける-moukeru, establish,provide|
|鉄筋-tekkin, steel, reinforce bar|発する-hassuru, emit, produce|アクセル-akuseru, accelerator|時折-tokiori, occasionally, now and then|
|響く-hibiku, echo, resound, use to describe sound|些細-sasai,minor,trival,insignificant|慌ただしい-awatadashii, hectic, busy|至る所-itarutokoro, everywhere|
|鳴る-naru, ring, sound|引っ切り無しに-hikkirinashini, continuously, incenssantly|出入りしている-deirishiteiru, going in and out|各課-kakuka, each department|
|並ぶ-narabu, be arranged, line up|いくつか-ikutuka, several, some|職員-shokuinn, staff, employee|相対する-soutaisuru, oppose, confront|
|ほど-hodo, about, approximately|届く-todoku, deliver, arrive|単純-tanjunn, simple, plain, unsophisticated|事務仕事-jimushigoto, office work|
|軽微-keibi, slight, minor|確認-kakuninn, confirmation, verification|手続き-tetuduki, process, procedue|軽い-karui, light, not heavy|
|口調-kuchou, tone of voice, manner of speaking|ごく-goku, very, completely|いつもどおり-itumodoori, as usual|日常的な-nichijoutekina, daily, routine|
|雰囲気-funiki, atmosphere, mood, ambiance|崩す-kuzusu, break, change|切る-kiru, cut|涙-namida, tear|
|焦る-aseru, be hurry, be impatient|満ちる-michiru, be full|送る-okuru, to send|脳内-nounai, in ones mind|
|連呼-renko, repeat continuously|関係-kankei, relation, connection|機関-kikan, organization, institution|送付-sending, dispatch, transmission|
|締め切り-shimekiri, deadline, cutoff|周囲-shuui, surrounding, environs|内容-naiyou, content, substance|悟る-satoru, discern, comprehend, realize|
|辺り-atari, surrounding, area|見回す-mimawasu, look around, survey|クズ-kuzu, trash, scum, loser|拾う-hirou, pick up, find|
|結果-kekka, result, consequence|どうやら-douyara, apparently, it seems|興味-kyoumi, interest|示す-shimesu, show, indicate|
|ホット-hotto, represent the sign sound|一息つく-hitoikituku, take a breath|改めて-aratamete, anew, once more, an action is being performed again, but with a new intention or seriousness|表情-hyoujyou, facial expression|
|引く-hiku, pull|締める-shimeru, tighten|二十歳-hatachi, twenty years old|真面目な-majimena, serious, honest|
|相応の-sououno, suitable, appropriate|落ち着く-ochituku, to be calm|演出する-ennshutusuru, produce, direct, create a certain effect||
|||||



- ーてみる：

このケーキ、おいしいから食べてみてください。-This cake is delicious, so please try eating it (and see how good it is).(Implies: "Taste it and see for yourself if it's delicious.")

見れば:conditional-地球からしてみれば means: "If one were to try to view/consider from Earth's perspective..." or "If you look at it from Earth's point of view..."

- 設ける-to provide、　設け られる-be provided、　設け　られている-has been provided. is set up

- passive form:

話すー話される、　遊ぶー遊ばれる、　買うー買われる、　歌うー歌われる

食べるー食べられる、　見るー見られる

するーされる、　来るー来られる(korareru)

- よう：

彼は子供のようだ。(He is like a child.)

これは夢のような話しだ。(this is a story like dream.)

星が宝石(houseki)のように輝いて(kagayaite)いる。(star is shinning like jewels)

- negative form ず:

行く　行かない　行かず

食べる　食べない　食べず

する　しない　せず

来る　来ない　

雨が降らず、川の水が干上(hia)がった。-It did not rain, the river water dried up.

ずに：

ご飯を食べずに仕事に行った。-I went to work without eating.

彼は誰にも言わずに国を出た。-He left the country without telling anyone.

ずにはいられない:

彼女の歌を聞くと、涙を流さず(nagasazu)にはいられない。-When I hear her song, I can't help but shed tear.

ずとも：

言わずともわかるだろう。-You'll probably understand even without me saying it.

- 連用形 = て used for combine two sentence

彼はかばんを持ち(mochi)、部屋を出た。(formal, literary) = 彼は鞄を持って、部屋を出た。

- ～まい probably not, will not

行く　行くまい　読む　読むまい　話す　話すまい

食べる　食べるまい　見る　見るまい

今日の会議は、もう始まるまい。

彼はそんな卑劣なことがするまい。

これで終わりではあるまい。＝これで終わりではないだろう。

- verb to num

落ち着く　落ち着き

始める　始め

楽しむ　楽しみ

## phone and windows pc ftp

when path appear "??" change the file name at the "??" place

## http_client

roadmap:
- dns resolve(done, upd->dns->parse the answer)
- write udp myself to replace the socket in the dns resolver()
- use ip to get html content


dns lookup->create socket->connect to server->send http request->receive response->close connection

dns resolver:

use resolvectl status to check the dns server now.

request->/etc/resolv.conf->systemd-resolved (127.0.0.53), use DHCP from NetworkManager or Static files (/etc/systemd/resolved.conf) or VPN client instructions.

```
// 12 bytes (1 + 3 padding + 4 + 1 + 3 padding)
struct AlignedStruct {
    char a;      // 1 byte
    int b;       // 4 bytes
    char c;      // 1 byte
};

// 6 bytes (1 + 4 + 1)
#pragma pack(push, 1)
struct PackedStruct {
    char a;      // 1 byte
    int b;       // 4 bytes
    char c;      // 1 byte
};
#pragma pack(pop)
// it align with 1 byte after #pragma pack(push, 1), and do not use the rule after pop right
```

This random number acts as a secret key for that specific transaction. Since there are 2^16 (65,536) possible values for the 16-bit Transaction ID, an attacker trying to guess the correct ID would have to send a massive number of forged responses in a very short window of time.

The C and C++ standards solved this problem by introducing size_t. The compiler is responsible for defining size_t to be the correct size for the target architecture

```
// get random number in c/cpp
uint32_t random_number; // Use a 32-bit unsigned integer
size_t size_to_read = sizeof(random_number);
result = getrandom(&random_number, size_to_read, 0);
```

PTR(pointer Record):dns can use domain get ip, ptr can not ensure from ip to specific domain

different computer architectures store multi-byte data in different ways.Before sending multi-byte data (like IP addresses, port numbers, or lengths) over the network, a host must convert its native byte order to network byte order (big-endian).Upon receiving multi-byte data from the network, a host must convert it from network byte order back to its native byte order.

UDP is not a streaming protocol — there’s no “send answer 1, then later answer 2” — it’s one datagram.

UDP is “fire and forget”:

If the packet is lost, corrupted, or dropped:
No automatic retry from UDP — the application (DNS client) must decide to resend after a timeout.

If too big: server sets the TC (Truncated) flag in the DNS header → client retries over TCP.

If unreachable: a router might send back ICMP error (Destination Unreachable), but many networks block these, so the client still just waits for timeout.

Max DNS packet without EDNS0: 512 bytes, larger than that, server will truncate it.

How real DNS clients handle this:Try UDP first (fast, simple).If TC=1 → automatically switch to TCP and resend the query.Parse the complete response over TCP.That’s why in most DNS libraries or system resolvers you rarely notice truncation — the library handles the TCP fallback for you.

You purchase a domain name (e.g., mydomain.com) from a domain registrar.

You have a server with a public IP address (e.g., 123.45.67.89).

For your domain to be usable, you must set up an authoritative DNS server for it. This is the crucial step. You have two main choices here:

use domain->recursive dns(1.1.1.1)->get ip from authoritative dns or its cache

if auth dns give recursive dns ip ttl=60s and I get ip from recursive dns at 30s after it get from auth dns, the ttl I get is 30s.

## measure theory

author of the book: Donald L.Cohn

now at page:26

**Introduction**

Riemann Integral--Darboux's definition: 

lower sum=upper sum, than it is riemann integral

Riemann Integral--Riemann's definition: 

many intervals $\delta a$: [a_0,a_1], ... [a_n-1,a_n], get $x_1 - x_n$ in them ,and $\limit_(\delta x->0)$ calculate the product.

Theorem 1 (The Fundamental Theorem of Calculus):interal and differentiable

Theorem 2:{f_n} converge to f and the order of limit and interal can change

Lebesgue interal: use y and measure x

chapter1: measure subset of R

chapter2:define lebesugue interal

chapter3:limit and interal deeply

chapter4:signed or complex values in measure, relationships between measures

chapter5:multivariable interal in Lebesuge interal

chapter6:Theorem 1 in Lebesuge interal

chapter7, 9: topological spaces

chapter8:Many deeper questions about measurable sets and functions

chapter10:probability theory 

**Chapter1 Measure**

measure->deal with subsets of X

sigma-algebra->measure->construct measure->basic Lebesgue measure->some techniques

sigma-algebra ->collections of subsets of arbitray set X->some property: contains X, closed under complementation, under the formation of countable unions, and under the
formation of countable intersections. 

set X->an algebra of sets (sometimes called a field of sets)->finite unions + complements.

sigma-algebra->countable unions + complements.

countable unions->union of infinitely many sets, but indexed in a sequence we can count->1, 2, 3...=N, 0, 1-1/2, 1-1/3, ... =[0,1-1/n]=[0,1)

co-finite->talks about the size of the complement->X=N=1,2,3..., A=N, A is infinite, but complement of A=null which is finite, so A is co-finite

algebra of a set is a tookit->algebra is a "finite" toolkit->whole X in collection + Complements(If you can measure an event, you can measure it not happening) + Finite Unions(finite sets union should can be measure)->measure A and NOT A, A OR B(union, A∪B={x∣x∈A or x∈B})->sigma-algebra(handle infinite but countable processes)->the same with algebra, but it need Countable Unions, countable sets A1, A2, ... their unions should in collection.->ensure we can measure limits 

if X has a sigma-algebra \sigma, subsets of X in \sigma called \sigma-measureable, you can use \sigma to measure the subsets in it.

example-X algebra, X sigma-algebra, both not->sigma-algebra:collection of all subsets of X, {null, X}, ->algebra but not sigma-algebra:collection of subsets of the natural numbers that are either finite or have a finite complement->both not: collection of all finite sets of X which is infinite

sigma-algebras intersection is sigma-algebra->just check the 3 properties

smallest sigma-algebra of X which contain collection A->mean sigma-algebra generated by collection A->denote sigma(A)->comes from the intersection of all sigma-algebras that contain A

borel(R)->a sigma-algebra of R->A=the collection of open subsets of R->borel(R)=sigma(A)->we can use [a,b], (a,b], (-inf, b] to build the same borel(R) too



## XXXX

存粹的傲慢......，弯下腰说两句好话都不会了。给你供吃的穿的，关键时刻业务能力为0，安抚的好话都不会说，只会把一切变得更加糟糕，六百六十六，演都不演了。

## Music Player with Memory Pool

understand by threads

threads:

shortcut thread: all app time-life, block in GetMessage() which get message from windows

cmd thread: block in `_getchar()`

player m_playlist_thread thread: block in m_command_cv.wait  

m_playback thread: loop to end or get command, not blocked

show time thread: busy-wait with sleep to get and show where the song now when cmd is visivle

use atomic variant to stop thread

## 读博客增长知识面

准备面试要增长自己的知识面，现在发现从一个博客文章开始，这篇文章为主题，先搞懂文章，然后和AI往深处讨论，这样可以拓宽知识面，而且不算很无聊

## 活着久

感觉有事情做或者没事情做都不太行，重要的是一种节奏，活得久，每天都有点东西玩玩就很舒服。

