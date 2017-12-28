import Foundation

class Json : SequenceType {
    let data:AnyObject?
    
    init(data:AnyObject?) {
        if (data is NSData) {
            do {
                self.data = try NSJSONSerialization.JSONObjectWithData(
                    data as! NSData,
                    options: NSJSONReadingOptions.AllowFragments)
            } catch _ {
                self.data = nil
            }
        } else {
            self.data = data
        }
    }

    func string() -> String { return data as? String ?? "" }
    func int() -> Int { return data as? Int ?? 0 }
    func float() -> Float { return data as? Float ?? 0.0 }
    func double() -> Double { return data as? Double ?? 0.0 }
    
    subscript(name:String) -> Json {
        let hash = data as? NSDictionary
        return Json(data: hash?.valueForKey(name))
    }
    
    func generate() -> AnyGenerator<Json> {
        let array = data as? [AnyObject]
        let length = array?.count
        var i = 0
        return anyGenerator {
            return i < length ? Json(data: array?[i++]) : .None
        }
    }
}
