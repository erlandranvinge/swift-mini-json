swift-mini-json
===============

A single class compact simple JSON reading library in swift. 

#### Properties

```swift
let car = NSData(...)
let json = JSON(data: data)
let carName = json["name"].string()
let modelName = json["model"]["name"].string()
```

#### Arrays

```swift
for color in json["colors"] {
    let r = color["red"]
    let g = color["green"]
    let b = color["blue"]
}
```

#### Missing properties and error handling
If a property is missing, the default value is returned:

```swift
let s = json["missing-string"].string() // => ""
let i = json["missing-int"].int() // => 0
let f = json["missing-float"].float() // => 0.0
let d = json["missing-double"].double() // => 0.0
```

The same applies for invalid type conversions:
```swift
let s = json["string"].int() // => 0
```

