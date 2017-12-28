import Foundation

class Json: Sequence {
    private let data:AnyObject?
    
    init(data:AnyObject?) {
        if (data is NSData) {
            self.data = try? JSONSerialization.jsonObject(
                with: (data as! NSData) as Data,
                options: .allowFragments) as AnyObject
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
        return Json(data: hash?.value(forKey: name) as AnyObject)
    }
    
    subscript(index:Int) -> Json {
        guard let items = data as? [AnyObject] else { return Json(data: nil) }
        guard index >= 0 && index < items.count else { return Json(data: nil) }
        return Json(data: items[index])
    }
    
    func makeIterator() -> AnyIterator<Json> {
        guard let items = data as? [AnyObject] else {
            return AnyIterator { return .none }
        }
        
        var current = -1
        return AnyIterator {
            current = current + 1
            return current < items.count ? Json(data: items[current]) : .none
        }
    }
}

