# Presentation

All screens from IA SDK can be used in following manner:
* used as any other view (embedded)
* pushed to navigation
* presented (modal)

You need to specify `hostEmbedStyle`, this determines if SDK screens should show back button, dismiss button or no button in its navigation. Note that `hostEmbedStyle` doesn't actually push, present or embed, you are responsible for that, as with any other view.

**IMPORTANT:** Before doing and of this, make sure IA SDK is fully initialized.

## Embed
````swift
struct ExampleView: View {
    @StateObject var viewModel = HostAppViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                IAProductSearchScreen()
                    .tabItem { Text("Search") }
                
                IACartScreen()
                    .tabItem { Text("Cart") }
            }
        }
    }
}
````

## Push to navigation
````swift
struct ExampleView: View {
    @State var navigationPath: [Route] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Button("Push Product Search") {
                Task { navigationPath.append(.productSearch) }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .productSearch:
                    IAProductSearchScreen()
                        .hostEmbedStyle(.navigation(onDismiss: { navigationPath.removeLast() }))
                }
            }
        }
    }
}

enum Route: Hashable {
    case productSearch
}
````

## Present
````swift
struct ExampleView: View {
    @State var activeRoute: Route?
    
    var body: some View {
        VStack {
            Button("Present Product Search") {
                activeRoute = .productSearch
            }
        }
        .fullScreenCover(item: $activeRoute) { route in
            switch route {
            case .productSearch:
                IAProductSearchScreen()
                    .hostEmbedStyle(.presentation(onDismiss: { activeRoute = nil }))
            }
        }
    }
}

enum Route: Identifiable {    
    case productSearch
    
    var id: Self { self }
}
````
