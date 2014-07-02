# Tails

Tails is a take on declarative Auto Layout. If you don't like typing the same things several times (like me), it might be your kind of thing!

## Usage

Meet the *tail operator* (™): `~`. All you need to do to use your views in fully fledged layout equations is to grow them little tails:

```
Tails.install(
    view1~.top == self.topLayoutGuide~.bottom,
    view1~.left == view.superview~,
    view1~.width == 50,

    view2~.top == view1~,
    view2~.trailing == view1~.leading + 10,
    view2~.width >= view1~ * 2
)
```

Things become really cool with composite layout attributes:

```
Tails.install(
    view1~.size == CGSize(width: 60, height: 40),
    view1~.center == view2~ - CGPoint(x: 0, y: 20),

    view2~.edges == view2.superview~,
    
    view3~.top.left.width == view1~
)
```



