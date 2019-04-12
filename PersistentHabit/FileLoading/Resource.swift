
import Foundation

struct Resource<A:Decodable> {
    let fileName:String
    let fileExtension:String
    let type:A.Type
}


