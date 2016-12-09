M80AttributedLabel
==================


Another attributed label using CoreText


# Features
* Multi-line Rich Text Display
* Auto Link Detection and Custom Links Supported
* Embedding Image and Custom Views
* Following Properties Supported:
    * `font`
    * `textColor`
    * `highlightColor`
    * `linkColor`
    * `underLineForLink`
    * `numbersOfLines` (Truncates Last Line Supported)
    * `textAligment`
    * `lineBreakMode`
    * `lineSpacing`
    * `paragraphSpacing`
    * `shadowColor`
    * `shadowOffset`
    * `shadowBlur`

    

# System Requirement
* iOS 7.0 or later
* ARC required

# Installation
### Podfile
```ruby
pod 'M80AttributedLabel'
```
### Manually
* `git clone https://github.com/xiangwangfeng/M80AttributedLabel.git`
* Copy files in `Class/M80AttributedLabel` to your project
* Add `CoreText.framework` to your target

# Usage

## Basic

```objc

M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    
    label.text      = @"Hello M80AttributedLabel";
    label.font      = [UIFont fontWithName:@"Zapfino" size:25];
    label.textColor = M80RGB(0xFF9F00);
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset= CGSizeMake(1, 1);
    label.shadowBlur = 1;
    
    label.frame     = CGRectInset(self.view.bounds,20,20);

    [self.view addSubview:label];
   
```

![](./Documents/Images/Basic.png)

## Link

```objc

M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    
    NSString *text  = @"The game which I current play is hearthstone,and its website is www.hearthstone.com.cn";
    NSRange range   = [text rangeOfString:@"hearthstone"];
    label.text      = text;
    [label addCustomLink:[NSValue valueWithRange:range]
                forRange:range];
    label.delegate = self;
    
    
    label.frame     = CGRectInset(self.view.bounds,20,20);
    
    [self.view addSubview:label];


```

![](./Documents/Images/Link.png)


## Image

```objc


M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    label.lineSpacing = 5.0;
    
    [label appendImage:[UIImage imageNamed:@"avatar"
                        ] maxSize:CGSizeMake(40, 40)
                margin:UIEdgeInsetsZero
             alignment:M80ImageAlignmentBottom];
    
    NSString *text  = @"say:\n有人问一位登山家为什么要去登山——谁都知道登山这件事既危险，又没什么实际的好处。[haha][haha][haha][haha]他回答道：“因为那座山峰在那里。”我喜欢这个答案，因为里面包含着幽默感——明明是自己想要登山，偏说是山在那里使他心里痒痒。除此之外，我还喜欢这位登山家干的事，没来由地往悬崖上爬。[haha][haha][haha]它会导致肌肉疼痛，还要冒摔出脑子的危险，所以一般人尽量避免爬山。[haha][haha][haha]用热力学的角度来看，这是个反熵的现象，所发趋害避利肯定反熵。";
    
    //replace [haha] by image
    NSArray *components = [text componentsSeparatedByString:@"[haha]"];
    NSUInteger count = [components count];
    for (NSUInteger i = 0; i < count; i++)
    {
        [label appendText:[components objectAtIndex:i]];
        if (i != count - 1)
        {
            [label appendImage:[UIImage imageNamed:@"haha"]
                       maxSize:CGSizeMake(15, 15)
                        margin:UIEdgeInsetsZero
                     alignment:M80ImageAlignmentCenter];
        }
    }
    
    
    label.frame     = CGRectInset(self.view.bounds,20,20);
    
    [self.view addSubview:label];
    
    
```

![](./Documents/Images/Image.png)

## Attachemnt

```objc

M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    
    for (NSInteger i = 0; i < 3; i++)
    {
        [label appendText:@"Click the icon to fire event"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setBounds:CGRectMake(0, 0, 30, 30)];
        [button setTag:i];
        [label appendView:button];
        
        [label appendText:@"\n\n\n"];
    }
    

    
    label.frame     = CGRectInset(self.view.bounds,20,20);
    [self.view addSubview:label];

```

![](./Documents/Images/Attachment.png)

# Contact
* https://github.com/xiangwangfeng
* http://www.xiangwangfeng.com
* xiangwangfeng@gmail.com 
* http://weibo.com/epmao

[Apache]: http://www.apache.org/licenses/LICENSE-2.0
[MIT]: http://www.opensource.org/licenses/mit-license.php
[GPL]: http://www.gnu.org/licenses/gpl.html
[BSD]: http://opensource.org/licenses/bsd-license.php

# License

M80AttributedLabel is available under the [MIT license][MIT]. See the LICENSE file for more info.
