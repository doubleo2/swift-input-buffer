import SwiftUI

struct ContentView: View {
  @StateObject var vm: ViewModel = ViewModel()
    var body: some View {
      Form {
        VStack(alignment: .leading) {
          Text("Input Text")
            .font(.caption)
          TextField("", text: $vm.inputText)
        }
        VStack(alignment: .leading) {
          Text("Delay (ms)")
            .font(.caption)
          TextField("", value: $vm.inputDelay, formatter: NumberFormatter())
            .keyboardType(.numberPad)
        }
        Button(
          action: {
            vm.submit()
          },
          label: {
            Text("Submit")
          })
        Section("Output") {
          Text("\(vm.output)")
        }
      }
      .onAppear(perform: {
        print("onAppear")
        vm.startConsumer()
      })
      .onDisappear(perform: {
        print("onDisappear")
        vm.stopConsumer()
      })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
