---
title: shixian4
date: 2025-07-26
author: anaouse
layout: doc
---

## note manager "## selector"

**roadmap**

- shortcut open and close(done, use QAbstractNativeEventFilter get win32 system hotkey)->
- latest sorted(done,but now it is dir latest md is not)->
- search bar result enable using arrow(done, override QLineEdit to process keyboard event to use arrow to activate item)->
- latest edited sorted()->
- md latest sorted()->

Q_OBJECT Macro: Enables Qt's meta-object compiler (moc) to process the class for signals and slots, a core mechanism for event handling in Qt.

Signals: Emitted when an event occurs (e.g., a button is clicked, text changes).

Slots: Functions called in response to signals. In your header, the public slots and private slots sections declare functions that can be connected to signals.

qt valid grammar, public slots:

The connect function establishes a connection so that when the signal occurs, the slot is automatically executed:

QObject::connect(sender, &SenderClass::signal, receiver, &ReceiverClass::slot);

Meaning: Every time the user types or edits text in m_searchLineEdit, the onFilterChanged function in the TitleSelector class is called.

Meaning: When the user double-clicks or presses Enter on an item in m_listWidget, the onItemActivated function in the TitleSelector class is called.

&Class::function is C++ syntax for a pointer to a member function

QRegularExpression regex("^##\\s+(.+)$"); : What it matches: Lines that start with ##, followed by at least one whitespace, and then any sequence of characters until the end of the line. The text after the whitespace is captured in a group. useful but not readable use AI for it.


## idea

感觉为了快速实现功能而一直复制粘贴很难受，还是一个个字符敲比较舒服，这样逻辑就很清楚很舒服，反正也不急着干嘛。事无巨细地知道逻辑感觉也挺有意思，至少脑子是专注的，这种状态就很舒服。

一个一个字打变成了真正的vibe coding，复制粘贴变成了劳作😃

## sublime config

it do not show .exe .o .lib file in default

ctrl+G to jump to specific line

## linux

vim ~/.bashrc to modify initial command before starting a bash

## duck db monitor 1m kline

**road map**

- multithread get kline data(done, use vector<thread> to dispatch curl task and use std::lock_guard<std::mutex> lock(mutex) which is RAII lock to write the data, and std::atomic<int>& success_count to count)
- dingding info(done, use curl post set specific header)
- get data and multithread calculate it()

use reference in function variant or it will copy one is time wasting. 

## custom open webui frontend

goal: make my json data to interactived bubble, choose wrong answer will report wrong, choose right will show the explanation.

```
{
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
- show my json in interactive multi-choice quiz format(done, get the message and if it has my flag do not show it until getting all data, if it is normal json just show it.)
- rag let the model output mullti-choice quiz in my json format()

ollama bug: Error: llama runner process has terminated: exit status 2

I got the same error. I just installed microsoft visual redistributable c++ latest version. It is working for me and restart: https://github.com/ollama/ollama/issues/8770

llm->src\lib\components\chat\Messages\ResponseMessage.svelte->render:

Summary: The Lifecycle of a Message in this Component

Initiation: A new message object is created in the history store with done: false and an empty content string. The component renders a <Skeleton /> loader.

Streaming: The parent component receives tokens from the LLM and appends them to message.content in the history store.

Real-time Update: The $: ... block in ResponseMessage detects the change and updates its view, showing the growing text inside the <ContentRenderer />.

Completion: The stream ends. The parent component sets done: true in the history store.
Final Render: The component updates one last time. Now, because message.done is true, the action buttons (Copy, Edit, Regenerate, Rate) and any follow-up prompts appear below the completed message.
So, to summarize, yes, this component is explicitly designed to handle and display streaming responses in real-time.

## leetcode

**15 3sum**

sort it first, and two pointers to get the target -nums[i]

**16 3sum closest**
the same as 15, use two pointers



