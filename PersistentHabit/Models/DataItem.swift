
import Foundation

struct DataSet: Decodable {
    let month:String
    let average:Float
    let status:Int
    let data:[DataItem]
}

struct DataItem: Decodable {
    let day:String
    let value:Int
}



