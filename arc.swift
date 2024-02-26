struct passengercar: Hashable {
    var mark: String
    var annum: Int
    var trunkVolume: Double
    var engineRunning: Bool
    var windowsOpen: Bool
    var trunkVolumeFill: Double

    mutating func k(act: passengercarAction) {
        switch act {
        case .startEngineRunning:
            engineRunning = true
        case .stopEngineRunning:
            engineRunning = false
        case .openWindow:
            windowsOpen = true
        case .closeWindow:
            windowsOpen = false
        case let .trunkl(v):
            trunkVolumeFill = trunkVolumeFill+v
        case let .trunku(v):
            trunkVolumeFill = trunkVolumeFill-v
        }
    }
}

enum passengercarAction {
    case startEngineRunning
    case stopEngineRunning
    case openWindow
    case closeWindow
    case trunkl(Double)
    case trunku(Double)
}

var pcar = passengercar(mark: "Toyota", annum: 2018, trunkVolume: 350, engineRunning: true, windowsOpen: true, trunkVolumeFill: 100)

pcar.k(act: .startEngineRunning)
pcar.k(act: .openWindow)
pcar.k(act: .trunkl(100))


struct truck: Hashable {
    var mark: String
    var annum: Int
    var trunkVolume: Double
    var engineRunning: Bool
    var windowsOpen: Bool
    var trunkVolumeFill: Double
    
    mutating func k(act: passengercarAction) {
        switch act {
        case .startEngineRunning:
            engineRunning = true
        case .stopEngineRunning:
            engineRunning = false
        case .openWindow:
            windowsOpen = true
        case .closeWindow:
            windowsOpen = false
        case let .trunkl(v):
            trunkVolumeFill = trunkVolumeFill+v
        case let .trunku(v):
            trunkVolumeFill = trunkVolumeFill-v
        }
    }
}


var trucks = truck(mark: "Volvo", annum: 2012, trunkVolume: 1010, engineRunning: false, windowsOpen: true, trunkVolumeFill: 145)

trucks.k(act: .stopEngineRunning)
trucks.k(act: .openWindow)
trucks.k(act: .trunku(105))

var dict = [pcar: "car1", trucks: "truck1"] as [AnyHashable: String]
print(dict)

//////////////////////////////////////////////////////////////////////////
class Car {
    // Добавляем слово weak
    weak var driver: Man?
    deinit{
    print("машина удалена из памяти")
    }
}
class Man {
    var myCar: Car?
    deinit{ 
        print("мужчина удален из памяти")
    }
}
var car: Car? = Car()
var man: Man? = Man()
car?.driver=man
man?.myCar=car
car = nil
man = nil
//////////////////////////////////////////////////////////////////////////////
class Man {
  var pasport: (() -> Passport?)? 
  deinit {
    print("мужчина удален из памяти")
  }
}
class Passport {
  let man: Man
  init(man: Man){
      self.man = man
  }
  deinit {
      print("паспорт удален из памяти")
  }
}
var man: Man? = Man()
var passport: Passport? = Passport(man: man!)
man?.pasport = { [weak passport] in
  return passport 
}
passport = nil
man = nil
///////////////////////////////////////////////////////////////////////////
// strong capturing Это означает, что замыкание захватывает используемые внешние значения и никогда не позволит им освободиться.
Будет выведено Good morning
import Foundation
 class greeting {
    func greetings() {
        print("Good morning")
    }
}
 
 func g() -> () -> Void {
    let taylor = greeting()

    let greeting1 = {
        taylor.greetings()
        return
    }

    return greeting1
}

let greetingFunction = g()
greetingFunction()

// weak capturing  «Слабо» захваченные значения не удерживаются замыканием и, таким образом, они могут быть освобождены и установлены в nil. «слабо» захваченные значения в Swift всегда optional
import Foundation
 class greeting {
    func greetings() {
        print("Good morning")
    }
}
 
 func g() -> () -> Void {
    let taylor = greeting()

    let greeting1 = { [weak taylor] in
        taylor?.greetings()
        return
    }

    return greeting1
}

let greetingFunction = g()
greetingFunction()

// unowned capturing
На самом деле taylor будет освобождён практически немедленно и этот код закончится аварийно. Значения могут стать nil.

import Foundation
 class greeting {
    func greetings() {
        print("Good morning")
    }
}
 
 func g() -> () -> Void {
    let taylor = greeting()

    let greeting1 = { [unowned taylor] in
        taylor.greetings()
        return
    }

    return greeting1
}

let greetingFunction = g()
greetingFunction()

