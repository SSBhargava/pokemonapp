import UIKit
import RxSwift

//var greeting = "Hello, playground"
//
//print("bhargav")

//func createRxObserver() {
//    let r: Observable<Character> = Observable.create {
//        observer in
//        for i in "stranger" {
//            observer.on(.next(i))
//        }
//        observer.on(.completed)
//        return Disposables.create()
//    }
//
//    r.subscribe(
//        onNext: {k in print("this is the charecter \(k)")},onCompleted: {print("this is completed")})
//}
//
//createRxObserver()

//var k: BehaviorSubject<Int> = BehaviorSubject(value: 0)
//
//func createObs() {
//   /* k = Observable.create { obs in
//        for i in 1...2 {
//            obs.on(.next(i))
//        }
//        obs.onCompleted()
//        return Disposables.create()
//    }*/
//    for i in 1...4 {
//        k.on(.next(i))
//    }
//}
//
//func subs () {
//    k.asObservable().subscribe(
//        onNext: {l in print("this is the charecter \(l)")},onCompleted: {print("this is completed")})
//}
//
//subs()
//subs()
//createObs()



//
//

//let first: String? = nil
//let last: String? = nil
//
//
//func ne() -> String? {
//    return nil
//    return "\(first)) \(last))"
//}
//
//print(ne())

// this is check

//var raghu = {
//    print("this is raghu")
//}
//
//raghu()
//
//
//var paramm = { string in print(string)}
//paramm("rahghu")
//var sqr = { num -> Int in
//   return( num * num) }
//print(sqr(20))
//
func math(num: Int, operation: (Int,Int,Int)->Int) -> Int {
    
    print(num)
    print("asghdasgjkkahskd")
    return operation(num,num,num)+operation(num,num,num)
}
//
//print(math(num: 10,operation: sqr))
//
//print(math(num: 400){ x in x * x})
//
//print(math(num: 500){  $0 * $0})
//
//var sqrt1 = { num -> Int in num * num }
//
//print(sqrt1(10))

math(num: 20) { $0 * $1 * $2 }

math(num: 40) { a, b, c in
    return a+b+c
}

math(num: 5) { a, b, c in
    return a*b*c
}


math(num: 25, operation: {a,b,c in return a*b*c})

math(num: 25) { a,b,c in
    return a+b*c
}
