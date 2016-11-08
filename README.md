# YSBaseAlert
YSBaseAlert主要用于自定义alert控件。YSBaseAlert主要集中处理了show和dismiss方法。自定义alert的UI构造需要在子类实现。
Demo里有一个YSAlert继承自YSBaseAlert，可以作为自定alert的参照。
YSAlert的调用示例：
```
YSAlert *alert = [[YSAlert alloc] initWithTitle:nil message:@"This is a alert!" leftButtonTitle:@"ok" rightButtonTitle:@"cancel"];
[alert show];
```
