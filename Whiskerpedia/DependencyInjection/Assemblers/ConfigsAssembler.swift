import BackpackDI

@MainActor
public final class ConfigsAssembler {
    static func assemble(_ container: Container) {
        container.autoRegister(AppConfig.self, using: AppConfigImpl.init)
    }
}
