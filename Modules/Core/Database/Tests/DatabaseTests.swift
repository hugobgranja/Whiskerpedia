import Foundation
import Testing
import SwiftData
import DatabaseAPI
@testable import DatabaseImpl

struct DatabaseTests {
    @Model
    final class UserEntity {
        @Attribute(.unique) var id: UUID
        var name: String

        init(
            id: UUID,
            name: String
        ) {
            self.id = id
            self.name = name
        }
    }

    private let sut: Database

    init() throws {
        let schema = Schema([UserEntity.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: schema, configurations: modelConfiguration)
        self.sut = DatabaseImpl(container: modelContainer)
    }

    @Test("Add user")
    func testAddUser() throws {
        // Arrange
        let context = sut.makeContext()
        let user = UserEntity(id: UUID(), name: "John Doe")

        // Act
        sut.add(user, using: context)
        try sut.save(context: context)
        let fetchedUsers = try sut.fetchAll(type: UserEntity.self, using: context)

        // Assert
        #expect(fetchedUsers.count == 1)
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUser == user)
    }

    @Test("Add multiple users")
    func testAddMultipleUsers() throws {
        // Arrange
        let context = sut.makeContext()
        let user1 = UserEntity(id: UUID(), name: "Bowie")
        let user2 = UserEntity(id: UUID(), name: "Peter")
        let user3 = UserEntity(id: UUID(), name: "Zynk")

        // Act
        sut.add(user1, using: context)
        sut.add(user2, using: context)
        sut.add(user3, using: context)
        try sut.save(context: context)
        let fetchedUsers = try sut.fetchAll(type: UserEntity.self, using: context)

        // Assert
        #expect(fetchedUsers.count == 3)
    }

    @Test("Fetch all users")
    func testFetchAllUsers() throws {
        // Arrange
        let context = sut.makeContext()
        let user1 = UserEntity(id: UUID(), name: "Alice")
        let user2 = UserEntity(id: UUID(), name: "Bob")

        // Act
        sut.add(user1, using: context)
        sut.add(user2, using: context)
        try sut.save(context: context)
        let fetchedUsers = try sut.fetchAll(type: UserEntity.self, using: context)

        // Assert
        #expect(fetchedUsers.count == 2)
    }

    @Test("Update user")
    func testUpdateUser() throws {
        // Arrange
        let context = sut.makeContext()
        let id = UUID()
        let user1 = UserEntity(id: id, name: "John Doe")
        let user2 = UserEntity(id: id, name: "Jane Doe")

        // Act
        sut.add(user1, using: context)
        try sut.save(context: context)
        sut.add(user2, using: context)
        try sut.save(context: context)
        let fetchedUsers = try sut.fetchAll(type: UserEntity.self, using: context)

        // Assert
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUsers.count == 1)
        #expect(fetchedUser.id == user2.id)
        #expect(fetchedUser.name == user2.name)
    }

    @Test("Delete user")
    func testDeleteUser() throws {
        // Arrange
        let context = sut.makeContext()
        let id = UUID()
        let user = UserEntity(id: id, name: "John Delete")
        let predicate = #Predicate<UserEntity> { $0.id == id }

        // Act
        sut.add(user, using: context)
        try sut.save(context: context)
        try sut.delete(using: context, matching: predicate)
        try sut.save(context: context)
        let fetchedUsers = try sut.fetchAll(type: UserEntity.self, using: context)

        // Assert
        #expect(fetchedUsers.count == 0)
    }

    @Test("Fetch with a predicate")
    func testFetchWithPredicate() throws {
        // Arrange
        let context = sut.makeContext()
        let user1 = UserEntity(id: UUID(), name: "Eve")
        let user2 = UserEntity(id: UUID(), name: "Frank")
        let nameToFind = user2.name
        let predicate = #Predicate<UserEntity> { $0.name == nameToFind }

        // Act
        sut.add(user1, using: context)
        sut.add(user2, using: context)
        try sut.save(context: context)

        let fetchedUsers = try sut.fetch(
            type: UserEntity.self,
            using: context,
            matching: predicate
        )

        // Assert
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUsers.count == 1)
        #expect(fetchedUser.name == user2.name)
    }

    @Test("Fetch sorted")
    func testFetchSorted() throws {
        // Arrange
        let context = sut.makeContext()
        let user1 = UserEntity(id: UUID(), name: "Bowie")
        let user2 = UserEntity(id: UUID(), name: "Peter")
        let user3 = UserEntity(id: UUID(), name: "Zynk")
        let sortDescriptor = SortDescriptor(\UserEntity.name)

        // Act
        sut.add(user3, using: context)
        sut.add(user1, using: context)
        sut.add(user2, using: context)
        try sut.save(context: context)

        let fetchedUsers = try sut.fetchAll(
            type: UserEntity.self,
            using: context,
            sortedBy: [sortDescriptor]
        )

        // Assert
        #expect(fetchedUsers.count == 3)
        #expect(fetchedUsers[0] == user1)
        #expect(fetchedUsers[1] == user2)
        #expect(fetchedUsers[2] == user3)
    }
}
