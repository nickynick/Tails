# Tails

Tails is a take on declarative Auto Layout. If you don't like typing (like me), it might be your kind of thing!

Tails currently supports iOS only, OSX support is coming soon.

## Usage

Meet the *tail operator* (™): `~`. To use your views in fully fledged layout equations, all you need to do is grow them little tails:

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

## Attributes

All `NSLayoutAttribute` values are available in Tails, as such: `left`, `right`, `top`, `bottom`, `leading`, `trailing`, `width`, `height`, `centerX`, `centerY`, `baseline`.

It is possible to use multiple attributes in the same equation by simply chaining them: `top.left`. There are several predefined composed ones: `size` (`width.height`), `center` (`centerX.centerY.`) and `edges` (`top.left.bottom.right`).

You may omit right side attributes to infer them from the left side of equation:
```
Tails.install(
    headerView~.top.left.right == containerView~
)
```

## Constants

Layout constants in Tails are not limited to scalar values. It is possible to use such structs as `CGPoint`, `CGSize` and `UIEdgeInsets`. They only affect specific layout attributes:

Constant               | Attribute
---------------------- | ---------
`CGPoint.x`            | `centerX`
`CGPoint.y`            | `centerY`
`CGSize.width`         | `width`
`CGSize.height`        | `height`
`UIEdgeInsets.top`     | `top`
`UIEdgeInsets.left`    | `left`
`-UIEdgeInsets.bottom` | `bottom`
`-UIEdgeInsets.right`  | `right`

For instance, this code:

```
let insets = UIEdgeInsets(top: 10, left: 20, bottom: 40, right: 20)

Tails.install(
    view~.top.left.right == superview~ + insets,
    view~.bottom == footerView~ + insets
)
```

Is equivalent to:

```
Tails.install(
    view~.top == superview~ + 10
    view~.left == superview~ + 20
    view~.right == superview~ - 20
    view~.bottom == footer~ - 40
)
```

## Priority

Use `~~` operator to specify constraint priority:

```
Tails.install(
    view1~.width <= view2~ ~~ UILayoutPriorityDefaultLow
)
```

## Tips and tricks

For alignment attributes, you may omit the right side view to refer to the left superview:

```
let insets: UIEdgeInsets(...)

Tails.install(
    view~.edges == insets
    // same as view~.edges == view.superview~.edges + insets
)
```

## Coming soon

- OSX support
- Tests (yeah, I know)
- More examples
- Constraint manipulation
- Kitties

## About

Tails shamelessly borrows many ideas from the wonderful [Masonry](https://github.com/Masonry/Masonry) by [Jonas Budelmann](https://github.com/cloudkite).

If you like Auto Layout DSL, you might also want to try [Cartography](https://github.com/robb/Cartography) by [Robert Böhnke](https://github.com/robb).
