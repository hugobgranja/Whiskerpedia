import Foundation
import BackpackDI

@MainActor
class AppContainer {
    private let container = Container()

    init() {
        assemble()
    }

    func assemble() {
        BreedsAssembler.assemble(container)
        ConfigsAssembler.assemble(container)
        CatClientAssembler.assemble(container)
        AppAssembler.assemble(container)
    }

    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(type)
    }
}
