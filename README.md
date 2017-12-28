swift-mini-json
===============

A single class compact (~ 40 loc) JSON reading library in swift. Meant to be dropped in to any project without fuzz. Most recent version was tested with swift 3.2 and 4.0. If you're stuck on an older version of swift, see the "legacy" folder for deprecated versions.

#### Properties

**JSON:**
```javascript
{ name: 'Ford', wheelCount: 4, weight: 2125.5, model: { name: 'F5' } }
```
**Swift:**
```swift
let car = NSData(...) // E.g. result from API, file read etc.
let json = Json(data: car)
let carName = json["name"].string()
let wheelCount = json["wheelCount"].int()
let weight = json["weight"].float()
let nestedModelName = json["model"]["name"].string()
```

#### Arrays
**JSON:**
```javascript
{ passengers: ['Kenny', 'Benny', 'Jenny', 'Lenny'] }
```
**Swift:**
```swift
for name in json["passengers"] {
    println(name.string()) 
}
```
**JSON:**
```javascript
{ 
    components: {
        wheels: [ 
            { brand: 'BrandA', radius: 55.0, boltCount: 16 }, 
            { brand: 'BrandB', radius: 56.0, boltCount: 18 } ],
        engine: /* ... */
    }
}
```
**Swift:**
```swift
for wheel in json["components"]["wheels"] {
    let brand = wheel["brand"].string()
    let radius = wheel["radius"].float()
    let boltCount = wheel["boltCount"].int()
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
for missing in json["missing"] { } // same as iterating over empty collection
```

The same applies for invalid type conversions:
```swift
let s = json["string"].int() // => 0
```
```swift
for item in json["string"] { } // same as iterating over empty collection
```

