import Foundation
import Testing
import SwiftData
import DatabaseAPI
@testable import DatabaseImpl

@MainActor
struct DatabaseTests {
    private let sut: any Database<UserEntity, User>

    init() throws {
        let schema = Schema([UserEntity.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: schema, configurations: modelConfiguration)
        
        self.sut = DatabaseImpl(
            container: modelContainer,
            mapper: UserMapper()
        )
    }

    @Test("Add user")
    func testAddUser() throws {
        // Arrange
        let user = User(id: UUID(), name: "John Doe")

        // Act
        sut.add(user)
        try sut.save()
        let fetchedUsers = try sut.fetchAll()

        // Assert
        #expect(fetchedUsers.count == 1)
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUser == user)
    }

    @Test("Fetch all users")
    func testFetchAllUsers() throws {
        // Arrange
        let user1 = User(id: UUID(), name: "Alice")
        let user2 = User(id: UUID(), name: "Bob")

        // Act
        sut.add(user1)
        sut.add(user2)
        try sut.save()
        let fetchedUsers = try sut.fetchAll()

        // Assert
        #expect(fetchedUsers.count == 2)
    }

    @Test("Update user")
    func testUpdateUser() throws {
        // Arrange
        let id = UUID()
        let user1 = User(id: id, name: "John Doe")
        let user2 = User(id: id, name: "Jane Doe")

        // Act
        sut.add(user1)
        try sut.save()
        sut.add(user2)
        try sut.save()
        let fetchedUsers = try sut.fetchAll()

        // Assert
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUsers.count == 1)
        #expect(fetchedUser == user2)
    }

    @Test("Delete user")
    func testDeleteUser() throws {
        // Arrange
        let id = UUID()
        let user = User(id: id, name: "John Delete")
        let predicate = #Predicate<UserEntity> { $0.id == id }

        // Act
        sut.add(user)
        try sut.save()
        try sut.delete(matching: predicate)
        try sut.save()
        let fetchedUsers = try sut.fetchAll()

        // Assert
        #expect(fetchedUsers.count == 0)
    }

    @Test("Fetch with a predicate")
    func testFetchWithPredicate() throws {
        // Arrange
        let user1 = User(id: UUID(), name: "Eve")
        let user2 = User(id: UUID(), name: "Frank")
        let nameToFind = user2.name
        let predicate = #Predicate<UserEntity> { $0.name == nameToFind }

        // Act
        sut.add(user1)
        sut.add(user2)
        try sut.save()

        let fetchedUsers = try sut.fetch(matching: predicate)

        // Assert
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUsers.count == 1)
        #expect(fetchedUser.name == user2.name)
    }

    @Test("Fetch sorted")
    func testFetchSorted() throws {
        // Arrange
        let user1 = User(id: UUID(), name: "Bowie")
        let user2 = User(id: UUID(), name: "Peter")
        let user3 = User(id: UUID(), name: "Zynk")
        let sortDescriptor = SortDescriptor(\UserEntity.name)

        // Act
        sut.add(user3)
        sut.add(user1)
        sut.add(user2)
        try sut.save()

        let fetchedUsers = try sut.fetchAll(sortedBy: [sortDescriptor])

        // Assert
        #expect(fetchedUsers.count == 3)
        #expect(fetchedUsers[0] == user1)
        #expect(fetchedUsers[1] == user2)
        #expect(fetchedUsers[2] == user3)
    }
}
