import UIKit
import RxSwift
import RxRelay
import RxCocoa

var greeting = "Hello, playground"
//
//print("bhargav")
//
//func createRxObserver() {
//
//    let r: Observable<Character> = Observable.create {
//        observer in
//        for i in "stranger" {
//            observer.on(.next(i))
//        }
//        observer.on(.completed)
//        observer.on(.next("c"))
//        return Disposables.create()
//    }
//
//    r.subscribe(
//        onNext: {k in print("this is the charecter \(k)")})
//}
//
//createRxObserver()

var disposeBag: DisposeBag? = DisposeBag()

var publish = PublishRelay<Int>()

var behavior = BehaviorRelay(value: 0)

var pubDispose: Disposable?

func createObs() {
    for i in 1...4 {
        behavior.accept(i)
        publish.accept(i)
    }
    
}

func subs () {
    behavior.asObservable().subscribe(
        onNext: {l in print("this is the behavior \(l)")},onCompleted: {print("this is behavior completed")}).disposed(by: disposeBag!)
}

func pub(){
    pubDispose = publish.asObservable().subscribe(
        onNext: {l in print("this is the publish \(l) ismainthread : \(Thread.isMainThread)")},onCompleted: {print("this is publish completed")})
}

subs()
pub()
createObs()

publish.accept(5)





let first: String? = nil
let last: String? = nil


func ne() -> String? {
    return nil
    return "\(first)) \(last))"
}

print(ne())
