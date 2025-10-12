---
title: shixian8
date: 2025-10-05
author: anaouse
layout: doc
---

## 信息源url存储器

每周日一个时间浏览信息源都讲了什么即可

## C# dotnet

Models(数据类型) View(展示数据) ViewModels(处理交互与读写) MVVM 设计模式

类当中的成员变量私有, 然后使用get和set属性而不是直接修改变量

`public string Name { get; set; }`=>

```
private string _name = string.Empty;

public string Name
{
    // The 'get' accessor reads the value from the backing field.
    get
    {
        return _name;
    }

    // The 'set' accessor writes the new value ('value' keyword) to the backing field.
    set
    {
        _name = value;
    }
}
```
partial, 说明这是这个类的一部分, 这样可以一个类写在多个文件当中

`private ObservableCollection<UrlItem> _urlItems = new();`=>`private ObservableCollection<UrlItem> _urlItems = new ObservableCollection<UrlItem>();` 简化了

`
[ObservableProperty]
private ObservableCollection<UrlItem> _urlItems = new();
` =>

使用生成器简化代码, 可以让内容改变后实时反应到UI上

```
public string Name
{
    get => _name;
    set
    {
        if (_name != value)
        {
            _name = value;
            OnPropertyChanged(nameof(Name)); // INotifyPropertyChanged
            OnNameChanged(value);            // 调用 partial 回调
        }
    }
}

partial void OnNameChanged(string value);
```
私有字段 (Private Fields): 习惯上使用 小驼峰命名法，并且通常以下划线 _ 开头

公共属性 (Public Properties): 帕斯卡命名法Name

`[RelayCommand]`自动生成Command接口(被view调用的):

`private void AddUrl()`=>`AddUrlCommand`

---

dotnet watch 才可以看到控制台输出, dotnet run不行

---

基于类?额,语法糖很多啊,但是了解后确实很简洁明了,以及编译后内存还有体积都有点大

## 开放感

地足够大, 建筑足够大, 人足够少, 这种自然景观或者建筑占据的空间比人多得多的时候就会有一种很舒服的开放的感觉 

## Kindle充不进电

想重新使用结果充了以下黄灯亮, 但是感觉充不进电, 因为长按电源也只是闪烁一下然后回到感叹号电池的界面.

后来用笔记本电脑充了一下, 然后拔下充电线对充电口吹气再重新插上电脑充电就启动了, 难绷

参考:

https://www.zhihu.com/question/328247039

补充, 后面电脑无法识别的时候其实就是线的问题, 换到买的时候送的线就好了, 看网上也是要换线试到好的那根

## github ssh连接失效

更改指纹的原因

查看.ssh/known_hosts文件中对应的域名, 我使用:

`ssh-keygen -R "[ssh.github.com]:443"`

然后重新push或者`ssh -T git@github.com`然后yes创建新指纹即可

## 编辑这件事
突然感觉其实一直在做的事情是通过键盘编辑各种各样的文字, 因为过于频繁, 导致没用慎重地思考自己在编辑什么东西, 有没有一种可能, 其实根本不需要编辑那么多东西? 或者说, 很多东西其实可以编辑一点其实就足以完成?

如果需要不停地切文件, 不停地输入, 甚至说不停地复制粘贴, 那么是否写的东西其实毫无价值?

打字, 使用键盘这个过程感觉很爽, 因为让人觉得在不断表达, 在"编辑", 改变着什么

## powertoys 重映射

caps lock变为中英文转换键, 不是强调这个软件, 而是去质疑并改进自己日常生活中那些常用但低效的行为很爽

## NeoVim

插件装到runtime时候会检测的路径下, C:\Users\WH\AppData\Local\nvim

nvim-tree enter变为打开一个tab->打开后sidebar消失, 再默认执行一次toggle

tree-sitter一切配置正常但是看不出高亮, 原来是颜色问题, 试一下切换即可 :colorscheme slate

split window `:vs file2.txt`, `ctrl+w w`跳转切换窗口聚焦

/用于搜索, n向下N向上, 然后:noh用于关闭高亮

toggleterm使用nushell的时候报错/s, 然后配置里写

## keyboaholic

为什么喜欢电脑?现在发现可能全部是因为键盘,我,或者说地球上一部分人有这样的键盘成瘾症

并不是只是用键盘就比用鼠标快,而是享受一种输入的,敲击键盘的实时反馈就是最爽的,这也和内容无关.

无关内容无关效率.

在于一种互动感,我做了一些事然后产生了一些东西,更深层的是一种偏执的掌控欲,或者说洁癖?

需要一切都可以通过按键来达成目标,没错,我按了一下一件事情就必须发生,而不是要我拖动鼠标,再次说明和效率无关,按下键盘意味着发号施令,电脑是接受并执行命令的一方,使用鼠标意味着人类必须配合电脑,主动寻找和定位才能达成目标

除了形式上的命令之外,往往更了解从键盘的发号施令是在做什么,而鼠标的点点点与拖动则由于太过常用,会让人脑子停顿片刻

## 外出

这次回去拍毕业证照,额,感觉大城市还是走着没意思,那种野外的石头植物的环境下走起来应该比较舒服,比较搞的是回来时候的地铁上一个老爷爷一个老奶奶在我旁边看A股K线然后讨论股票,出去走走有意思的地方在这,但是总体还是不舒服,从地铁站走回学校以为是我印象中的那种很舒服的人行道,但是完全不是,也有是郊区的原因,感觉路上都是灰尘,灰蒙蒙的.

## Vimium

chrome下使用vim模式, 主要有j下滑k上滑,ctrl+f之后可以选择超链接,但是把/聚焦搜索栏给占用了,它有exclude功能,把/配置一下就好

在一些网页下使用i无法选定输入框的话可以使用gi来选第一个输入框

配合键盘鼠标的数字5表示点击太舒服了

真的很好用!😄

狠狠地用键盘向电脑下命令😡😡😡


## 版本与文档

额,用第三方库的时候一定要确定好版本和文档,有时候就是API改变的原因导致出错,而AI如果信息落后的话绝对排查不出来,这时候不停地问也不会有效果的

## 输入法上限

微软拼音输入法一直输入结果居然有一个上限,太多了就不给继续输入了

## 简拼

上次使用了双拼感觉费脑子,但是全拼又太费手了,于是发现了简拼这个东西,主要是手很舒服,当然我不是使用很复杂的简拼,只是对于常见的短语来说会用,主要是为了放松手指,就是只输入声母然后选择,相当于把全拼的一部分精力用在脑子上

## title-focus

nvim插件

todo:

展示一个悬浮窗,悬浮窗上上方一个搜索输入框,下方展示东西

'^##%s+(.+)$': ^必须从开头开始,%s匹配任何空白字符,+前面模式的一次或重复,()捕获组, .即任意字符除了换行符,+前面模式一次或重复即所有任意字符,$持续到结束.正则还是AI写的舒服,但是写一次搞懂一下大概运行逻辑



## Rust

---
安装在D盘,就是不知道会不会还要一些中间产物什么的到C盘去?

CARGO_HOME = D:\Rust\.cargo
RUSTUP_HOME = D:\Rust\.rustup

---
struct是数据,trait是行为?




