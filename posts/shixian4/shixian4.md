---
title: shixian4
date: 2025-07-26
author: anaouse
layout: doc
---

## note manager "## selector"

**roadmap**

- shortcut open and close(done, use QAbstractNativeEventFilter get win32 system hotkey, override nativeEventFilter and install to the app, before it become qt message, capture the event and handle by myself)
- latest sorted(done,but now it is dir latest md is not)
- search bar result enable using arrow(done, override QLineEdit to process keyboard event to use arrow to activate item, add my own searchbar and itemlist widget to layout to present)

Q_OBJECT Macro: Enables Qt's meta-object compiler (moc) to process the class for signals and slots, a core mechanism for event handling in Qt.

Signals: Emitted when an event occurs (e.g., a button is clicked, text changes).

Slots: Functions called in response to signals. In your header, the public slots and private slots sections declare functions that can be connected to signals.

qt valid grammar, public slots:

The connect function establishes a connection so that when the signal occurs, the slot is automatically executed:

QObject::connect(sender, &SenderClass::signal, receiver, &ReceiverClass::slot);

Meaning: Every time the user types or edits text in m_searchLineEdit, the onFilterChanged function in the TitleSelector class is called.

Meaning: When the user double-clicks or presses Enter on an item in m_listWidget, the onItemActivated function in the TitleSelector class is called.

&Class::function is C++ syntax for a pointer to a member function.

"^##\\s+(.+)$" : What it matches: Lines that start with ##, followed by at least one whitespace, and then any sequence of characters until the end of the line. The text after the whitespace is captured in a group. useful but not readable use AI for it.

## idea

感觉为了快速实现功能而一直复制粘贴很难受，还是一个个字符敲比较舒服，这样逻辑就很清楚很舒服，反正也不急着干嘛。事无巨细地知道逻辑感觉也挺有意思，至少脑子是专注的，这种状态就很舒服。

一个一个字打变成了真正的vibe coding，复制粘贴变成了劳作😃

## sublime config

it do not show .exe .o .lib file in default

ctrl+G to jump to specific line

## linux

vim ~/.bashrc to modify initial command before starting a bash

truncate -s 0 log.txt make log.txt file size become 0 bytes

rm a dir exist files in linux:rm -r directory_name

rename a file: mv "old_filename.txt" "new_filename.txt"

kill a process by name: killall name

wc -l test.txt: get test.txt line numbers

~/.ssh下配置输入公钥到authorized_key, 然后有一个设置文件要确保可以使用ssh连接然后就可以使用ssh了



## duck db monitor 1m kline

**road map**

- multithread get kline data(done, use `vector<thread>` to dispatch curl task and use `std::lock_guard<std::mutex> lock(mutex)` which is RAII lock to write the data, and `std::atomic<int>& success_count` to count)
- dingtalk info(done, use curl post specific json and header)
- get symbol volumns over 5000,and get them 10 klines to calculate bollinger band(done, but it seem useless)
- monitor price get amplitude over 2% symbols(done ,write a sql which get max open_time lines and calculate the amplitude)
- if there is symbol amplitude over 2%, access telegram news to get last news send to dingtalk (done, just use curl, next maybe more news source or use the AI to detect if the news is relative with the abnormal symbol) 

use reference in function variant or it will copy one is time wasting. 

## custom open webui frontend

goal: make my json data to interactived bubble, choose wrong answer will report wrong, choose right will show the explanation.

```
{
"flag":"myjson"
"question": "Your question here",
"A": "Option A",
"B": "Option B",
"C": "Option C",
"D": "Option D",
"answer": "A",
"explanation": "Explanation of why the correct answer is correct"
}
```

**road map**

- modify the chat data to show we can intercept the data(done, 798 line, content={message.content+'this is my custom message: '} can change the data in bubble)
- show my json in interactive multi-choice quiz format(done, get the message and if it has my flag do not show it until getting all data, if it is normal json just show it. and show message after 50 chars)
- create my own rag backend()
- chat message from openwebui to my rag backend()

ollama bug: Error: llama runner process has terminated: exit status 2

I got the same error. I just installed microsoft visual redistributable c++ latest version. It is working for me and restart: https://github.com/ollama/ollama/issues/8770

llm>>src\lib\components\chat\Messages\ResponseMessage.svelte>>render:

Summary: The Lifecycle of a Message in this Component

Initiation: A new message object is created in the history store with done: false and an empty content string. The component renders a Skeleton loader.

Streaming: The parent component receives tokens from the LLM and appends them to message.content in the history store.

Real-time Update: The $: ... block in ResponseMessage detects the change and updates its view, showing the growing text inside the ContentRenderer.

Completion: The stream ends. The parent component sets done: true in the history store.
Final Render: The component updates one last time. Now, because message.done is true, the action buttons (Copy, Edit, Regenerate, Rate) and any follow-up prompts appear below the completed message.
So, to summarize, yes, this component is explicitly designed to handle and display streaming responses in real-time.

## leetcode

- 15 3sum

sort it first, and two pointers to get the target -nums[i]

- 16 3sum closest

the same as 15, use two pointers

- 17 letter combinations of a phone number

string=>number 2-9=>new string=>combination the new string

"23"=>`vector<string>`="abc","def"=>whats this data struct, how to traverse? no no no

add a number to result and new number just use the exist result

"23"=>"2"=>"a","b","c"(use string(1,tem[i]), make char tem[i] appear once to let char become string)=>"3"=>"a"+"b","c","d" "b"+"b","c","d" "c"+"b","c","d"=>

- 152 Maximun Product Subarray

int vector=>two nested for loop can solve but not elegant=>at nums[i] the max product based on nums[i], max_product at nums[i-1], min_product at nums[i-1], so use dynamic programming

- 70 climb stairs

when you at ith stairs, you use 2 steps at i-2 or use 1 step at i-1, so dp[i]=dp[i-2]+dp[i-1]

- 18 4sum

as the same with 3sum, but it use long long to avoid overflowing

- 19 Remove nth Node From End of List

two pointer maintain a length n window, p_fast go to end and slow is the removed node, use a old_slow_p to record last node of slow_p

- 22 generate parentheses

one left exist, one right can add

there are `2*n` parentheses

add open parenthese or close parenthese when it is valid

open_num < n, can add it, close_num < n && close_num < open_num, can add it

recursive is OK, and breath-explore queue is OK. Key point is that one building string add open parenthese or close parenthese

- 2807 insert greatest common divisors(GCD) in linked list

two pointer calculate the GCD and insert it

- 1769 Minimum Number of Operations to Move all balls to each box

method 1:

for i=0...box.length-1
    for j=0...box.length-1
        if j is '1'
            re[i]+=abs(j-i)

method 2:

// balls from left to right
balls_on_left=0
moves_from_left=0
for i=0...boxes.length-1
    result[i]+=moves_from_left
    if boxes[i] is '1':
        balls_on_left+=1
    moves_from_left+=balls_on_left // every loop all balls' movement plus 1

// balls from right to left
balls_on_right=0
moves_from_right=0
for i=boxes,length-1...0
    result[i]+=moves_from_right
    if boxes[i] is '1':
        balls_on_right+=1
    moves_from_right+=balls_on_right // every loop all balls' movement plus 1

- 2161 Partition Array According to Given Pivot

loop nums and get greater than pivot append to tem

equl pivot element insert to front of tem

smaller element add to result directly

append tem to result

- 24 SwapPairs

use 3 ptr to change a pair(second node of last pairs, first node, seconde node), new a my_head as first node of first pairs, and change first and second, fix pre's next

record this problem is a waste of time

0,1,2

## gnucash

use gnucash to record my money and time. lets goooooo.

gnucash use a acount transfer to another acount to record.

## 做啥

感觉想写的桌面软件都写完了，不知道要做啥，要么进公司干一些具体的业务的活要么就看书寻找人生的意义了，感觉还是要了解到深层次或者现实世界当中才够舒服。

## Shortcuts

alt+`:select english under mouse and translate

ctrl+\ : pop up window, input english or chinese will translate it

ctrl+alt+t: pop up timer

ctrl+alt+;: note manager 

ctrl+alt+p: open the music player

windows+alt+n: onenote open draft note

ctrl+`: sublime text open nushell

ctrl+1:  sublime text open nushell with msvc x64 env

reaper: ctrl+alt+a toggle piano roll

windows 回收站：explorer.exe shell:RecycleBinFolder

## grocery

- C++中右值引用（Rvalue Reference）的用途，以及它在实现移动语义（Move Semantics）中的作用。

右值引用是一种新的引用类型，它专门绑定到右值，比如字面量、临时对象或者 std::move 的结果

std::move 是一个将左值强制转换为右值引用的函数模板。它本身不执行任何移动操作，只是提供了一个“可以移动”的信号。当一个对象通过 std::move 转换后，如果它有对应的移动构造函数或移动赋值函数，编译器就会选择调用这些函数，从而实现真正的资源移动。

- std::atomic如何保证操作的原子性？它和互斥锁（Mutex）有什么区别？

std::atomic 是一个类模板，用于封装一个类型，并确保对该类型的所有操作（如读、写、修改）都具有原子性。原子性意味着该操作是不可中断的，要么完全执行，要么完全不执行，不会被其他线程的执行所干扰。std::atomic 通常是基于底层硬件CPU指令提供的原子指令（如 x86 架构下的 LOCK 前缀指令）实现的。这些指令可以直接在内存层面保证操作的原子性，相比软件层面的锁，性能更高，开销更低。粒度:std::atomic 针对单个变量或内存位置的操作，粒度非常细。std::mutex保护的是一段代码块（临界区），粒度相对较粗。

- 内存池

new/delete 的问题：在底层通常会涉及到操作系统级别的内存分配和释放系统调用（如Linux的 brk/mmap，Windows的 VirtualAlloc/HeapAlloc）。这些系统调用需要从用户态切换到内核态，开销非常大，可能达到微秒甚至更长，且时间不确定。内存管理器开销： 标准库的内存管理器（如 malloc/free 的C++版本）为了通用性，需要处理各种大小的内存请求，维护复杂的空闲块链表，搜索合适的内存块，这本身就需要进行额外的计算和锁定（如果多个线程同时请求内存），导致更高的延迟。内存碎片： 频繁地分配和释放不同大小的内存块会导致堆内存出现大量不连续的小空洞，即内存碎片。这不仅会降低缓存局部性，还可能导致后续大块内存分配失败，即使总内存充足。非确定性： 每次 new 或 delete 的耗时都可能因为操作系统调度、内存管理器状态、CPU缓存状态等因素而剧烈波动，这在需要毫秒甚至微秒级确定性响应的交易系统中是不可接受的“延迟抖动（Jitter）”。

内存池 (Memory Pool)原理：在系统启动时（或者在非关键路径上），预先向操作系统申请一大块连续的内存（例如，通过 mmap 或 VirtualAlloc）。然后，这个大内存块被划分为许多小块，形成一个自定义的内存管理系统。

使用new (rawMemory) MyClass()直接在内存地址分配对象

- 缓存对齐

CPU 寄存器： 最快，容量最小。CPU 缓存（L1, L2, L3 Cache）： 速度次之，容量适中，位于CPU和主内存之间。它们旨在存储CPU可能很快再次访问的数据，以减少对慢速主内存的访问。主内存（RAM）： 速度最慢，容量最大。硬盘/SSD： 更慢，容量更大。

CPU缓存通常以缓存行（Cache Line）为最小单位进行数据传输。一个缓存行的大小通常是 64字节

什么是缓存对齐？缓存对齐是指确保数据结构或变量的起始地址是缓存行大小（或其倍数）的整数倍。 也就是说，如果你的缓存行大小是64字节，那么一个缓存对齐的变量或结构体的起始地址就应该是0, 64, 128, 192... 等64的倍数。为什么要进行缓存对齐？缓存对齐的主要目的是提高程序性能，减少因为缓存未命中（Cache Miss）和假共享（False Sharing）带来的性能损失。

非对齐的风险： 如果一个数据结构（例如，一个结构体或一个大数组的元素）跨越了两个缓存行的边界，那么CPU在访问它时，可能需要加载两个缓存行才能获取到完整的数据。这会导致更多的内存访问，增加缓存未命中，从而降低性能。

当两个或多个线程独立地修改位于同一个缓存行中的不同变量时，就会发生假共享。

线程A修改变量X（X在缓存行L中）。线程B修改变量Y（Y也在缓存行L中）。当线程A修改X时，CPU核心A会将缓存行L标记为脏（dirty），并获得该缓存行的独占所有权。当线程B尝试修改Y时，它发现缓存行L已经被核心A独占并标记为脏。核心B必须等待核心A将L写回主内存。

要么手动填充结构体或者类为整行整行的，要么使用alignas

- 进程线程协程
进程 拥有独立的地址空间和系统资源。操作系统分配资源的基本单位。它拥有独立的地址空间（内存）、文件描述符、打开的端口、独立的页表等。一个进程崩溃通常不会影响其他进程。适用于独立、需要强隔离、容错性高的任务，如浏览器标签页、不同服务等。

线程 相比进程，不再拥有独立的地址空间和大部分系统资源，而是共享进程的，但拥有独立的执行栈和寄存器。CPU 调度的基本单位。同一个进程内的所有线程共享进程的地址空间和大部分资源（如文件描述符、全局变量等），但每个线程拥有独立的栈、程序计数器(PC)、寄存器集合以及线程本地存储(TLS)。一个线程的崩溃通常会导致整个进程崩溃。适用于需要利用多核CPU、进行并行计算、或者处理I/O密集型任务（通过线程池）的场景。

协程 相比线程，不再拥有独立的操作系统调度权，而是运行在用户态，通过协作式调度共享线程的执行资源。 是一种用户态的轻量级并发单元。它运行在单个线程之内，并且共享该线程的所有资源，包括栈（通常是在堆上模拟出栈，或者在一个大栈上分片）。协程没有独立的操作系统资源，其上下文切换开销极小。适用于高并发、I/O密集型任务（如网络服务），能够以同步编程的方式实现异步效果，避免回调地狱，同时具有极低的上下文切换开销，提高资源利用率。

- std::thread

线程开始运行的实际时间点是 std::thread 对象构造并传入可调用对象（如函数、Lambda表达式或函数对象）时。一旦 std::thread 对象被成功构造，它就会尝试启动一个新线程，并在新线程中执行您提供的可调用对象。

阻塞调用线程： 调用 join() \的线程（我们称之为“调用线程”，比如主线程）会立即被阻塞。它会暂停自身的执行，直到被 join() 的那个线程（我们称之为“被连接线程”）完成其所有任务并退出。

- QT signal-slot

MOC 是Qt特有的一个预处理器。它会在C++编译器之前运行。
当MOC发现一个类声明中包含 Q_OBJECT 宏时，它会扫描这个类的定义（包括 signals、slots、properties 等关键字），然后生成一个额外的C++源文件，通常命名为 moc_yourclass.cpp。这个 moc_*.cpp 文件包含了类的元信息 (Meta-information)，例如：类名、父类名。所有信号和槽的字符串名称、它们的参数类型和顺序。一个静态的 QMetaObject 对象，它提供了运行时反射能力。实现信号发射（emit 宏展开）和槽函数调用的底层代码。

调用 QObject::connect() 函数时，它并不会在编译时建立直接的函数指针连接。相反，它会在运行时进行连接。

运行时反射 是指一个程序在运行时（Runtime），而不是在编译时（Compile Time），能够检查、发现、访问甚至修改其自身的结构、类型信息以及行为的能力。简单来说，就是程序能够“看清”自己，知道自己有哪些类、这些类有哪些成员变量、有哪些函数（方法）、哪些信号和槽，甚至能够通过名字来调用某个方法，或者读写某个属性，而这些信息在编写代码时可能并不知道具体是哪个类或哪个方法。

获取类名： 在 main 函数中，我们只有 QObject* 类型的指针 obj1 和 obj2。我们并没有在编译时知道它们具体是 QPushButton 还是 QLabel。但是，在运行时，我们通过 obj->metaObject()->className() 成功地获取到了它们的真实类名。

动态属性访问： 我们通过字符串名称 "text" 和 "flat" 在运行时设置和获取了 QPushButton 和 QLabel 的属性。这些属性的类型在编译时对 QObject* 指针来说是未知的，但在运行时，元对象系统能够找到并操作它们。这在例如 Qt Designer（它需要动态地编辑和显示组件的属性）或序列化/反序列化对象时非常有用。

- 函数的指针参数

`void solution(ListNode *head, int n)`
修改head->val会在外面生效，但是修改head本身外面不会生效

- 初始化与生命周期
```
int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}
```
temp can not be used outside of "while"

- quick sort

pick a pivot element p, elements who are smaller than p go to p's left, larger than p go to p's right, and in the p's left and right part using the same method

assume using closed interval [low, high] for array

partition array[low, high]:
    pivot=array[high]
    divide elements smaller than pivot to pivot left, larger to right and return the position of pivot:
        smaller zone which is less than pointer i,
        unsorted zone which is controlled by pointer j,
        i=low-1
        for j from low to high-1:
            if(array[j]<=pivot)
                i++ // new small element
                swap(array[j], array[i])
        swap(array[i+1], array[high]) // swap pivot to position i+1, if all larger than pivot, than pivot position will be i+1=low which is the first place

quick_sort(array, low, high):
    if low< high:
        return
    partition
    quick_sort(left_part)
    quick_sort(right_part)

- stringstream

in-memory stream, make string like stream from file or read file to whole string

```
std::string data = "John Smith 28 male";
std::stringstream ss(data);
std::string first_name, last_name, gender;
int age;
ss >> first_name >> last_name >> age >> gender;

std::ifstream input_stream("input.txt");
std::stringstream input_ss;
input_ss << input_stream.rdbuf();
std::string file_str=input_ss.str()
```

## 欲望队列

感觉不能够一下子有太多东西进到脑子里面，要做一件事情的时候赶紧把它做掉，或者做一部分这样可以缓解很多焦虑。这样专注于解决自身想要做的事情不会想太多，自然而然就自带专注的效果就很舒服，就像是队列一样，有什么想做的就赶紧先做掉，把产生的欲望解决了，而不是堆积太多，那样很难受。



