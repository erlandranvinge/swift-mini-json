swift-mini-json
===============

A single class compact simple JSON reading library in swift. 

#### Properties

```swift
let data = NSData(...) // E.g. result from API, file read etc.
let json = Json(data: car)
let carName = json["name"].string()
let carName = json["wheels"].int()
let carName = json["weight"].float()
let nested = json["model"]["name"].string()
```

#### Arrays

```swift
for name in json["names"] {
    println(name.string()) 
}
```
```swift
for color in json["car"]["colors"] {
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
```swift
for color in json["missing"] {} // same as iterating over empty collection
```

The same applies for invalid type conversions:
```swift
let s = json["string"].int() // => 0
```
```swift
for color in json["string"] // same as iterating over empty collection
```

