import Foundation

final class ViewModel: ObservableObject {
  @Published var inputText = "One character at a time"
  @Published var inputDelay = 100
  @Published private(set) var output = ""
  private var queue = SharedQueue<Keystroke>()
  private var consume = false

  func startConsumer() {
    print("Consumer started...")
    consume = true
    Task {
      while(consume) {
        let keystroke = await queue.take()
        usleep(UInt32(keystroke.delay * 1000 /* microseconds per millisecond */))
        type(keystroke.data)
      }
      print("Done")
    }
  }

  func stopConsumer() {
    // TODO: Does this even work?
    consume = false
  }
  
  func submit() {
    Task { [self] in
      for character in inputText {
        await queue.offer(item: Keystroke(data: String(character), delay: inputDelay))
      }
    }
  }

  func type(_ text: String) {
    DispatchQueue.main.async {
      self.output += text
    }
  }
}
