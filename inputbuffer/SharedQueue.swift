import Foundation

class SharedQueue<T> {
  let mutex = DispatchSemaphore(value: 1)
  let notEmpty = DispatchSemaphore(value: 0)

  var items: [T] = []

  func offer(item: T) async {
    print("offer")
    mutex.wait()
    items.append(item)
    mutex.signal()
    notEmpty.signal()
  }

  func take() async -> T {
    print("take")
    notEmpty.wait()
    mutex.wait()
    let item = items.removeFirst()
    mutex.signal()
    return item
  }
}
