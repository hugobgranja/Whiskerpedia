import Foundation
import DatabaseAPI

final class UserMapper: DBMapper {
    init() {}

    func map(entity: UserEntity) -> User {
        return User(id: entity.id, name: entity.name)
    }

    func map(object: User) -> UserEntity {
        return UserEntity(id: object.id, name: object.name)
    }
}
