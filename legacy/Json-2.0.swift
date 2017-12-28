import Foundation

class JsonGenerator: AnyGenerator<Json> {
    
    init(data:AnyObject?) {
        items = data as? [AnyObject]
        length = items?.count ?? 0
    }
    
    private let items:[AnyObject]?
    private let length:Int
    private var current = 0
    
    override func next() -> Json? {
        return current < length ? Json(data: items?[current++]) : .None
    }
}

class Json: SequenceType {
    let data:AnyObject?
    
    init(data:AnyObject?) {
        if (data is NSData) {
            self.data = try? NSJSONSerialization.JSONObjectWithData(
                data as! NSData,
                options: .AllowFragments)
        } else {
            self.data = data
        }
    }
    
    func string() -> String { return data as? String ?? "" }
    func int() -> Int { return data as? Int ?? 0 }
    func float() -> Float { return data as? Float ?? 0.0 }
    func double() -> Double { return data as? Double ?? 0.0 }
    func bool() -> Bool { return data as? Bool ?? false }
    
    subscript(name:String) -> Json {
        let hash = data as? NSDictionary
        return Json(data: hash?.valueForKey(name))
    }
    
    func generate() -> AnyGenerator<Json> {
        return JsonGenerator(data: data)
    }
}
