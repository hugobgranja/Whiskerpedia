import Foundation
import Testing
import SwiftData
import DatabaseAPI
@testable import DatabaseImpl

@MainActor
struct DatabaseTests {
    @Model
    final class User: Equatable {
        @Attribute(.unique) var id: UUID
        var name: String

        init(
            id: UUID = UUID(),
            name: String
        ) {
            self.id = id
            self.name = name
        }

        static func ==(lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id
        }
    }

    private let sut: Database

    init() throws {
        let schema = Schema([User.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: schema, configurations: modelConfiguration)
        self.sut = DatabaseImpl(container: modelContainer)
    }

    @Test("Add a new user")
    func testAddUser() throws {
        // Arrange
        let user = User(name: "John Doe")

        // Act
        try sut.add(user)
        try sut.save()
        let fetchedUsers = try sut.fetchAll(type: User.self)

        // Assert
        #expect(fetchedUsers.count == 1)
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUser == user)
    }

    @Test("Fetching all users")
    func testFetchAllUsers() throws {
        // Arrange
        let user1 = User(name: "Alice")
        let user2 = User(name: "Bob")

        // Act
        try sut.add(user1)
        try sut.add(user2)
        try sut.save()
        let fetchedUsers = try sut.fetchAll(type: User.self)

        // Assert
        #expect(fetchedUsers.count == 2)
    }

    @Test("Updating a user")
    func testUpdateUser() throws {
        // Arrange
        let userID = UUID()
        let user1 = User(id: userID, name: "John Doe")
        let user2 = User(id: userID, name: "Jane Doe")

        // Act
        try sut.add(user1)
        try sut.add(user2)
        try sut.save()
        let fetchedUsers = try sut.fetchAll(type: User.self)
        let fetchedUser = try #require(fetchedUsers.first)

        print(fetchedUsers.map { "\($0.id) \($0.name)"})

        // Assert
        #expect(fetchedUsers.count == 1)
        #expect(fetchedUser == user2)
    }

    @Test("Deleting a user")
    func testDeleteUser() throws {
        // Arrange
        let user = User(name: "John Doe")

        // Act
        try sut.add(user)
        try sut.delete(user)
        try sut.save()
        let fetchedUsers = try sut.fetchAll(type: User.self)

        // Assert
        #expect(fetchedUsers.count == 0)
    }

    @Test("Fetching with a predicate")
    func testFetchWithPredicate() throws {
        // Arrange
        let user1 = User(name: "Eve")
        let user2 = User(name: "Frank")
        let predicate = #Predicate<User> { $0.name == "Frank" }

        // Act
        try sut.add(user1)
        try sut.add(user2)
        try sut.save()

        let fetchedUsers = try sut.fetch(
            type: User.self,
            matching: predicate
        )

        // Assert
        let fetchedUser = try #require(fetchedUsers.first)
        #expect(fetchedUsers.count == 1)
        #expect(fetchedUser.name == "Frank")
    }

    @Test("Fetch sorted")
    func testFetchSorted() throws {
        // Arrange
        let user1 = User(name: "Bowie")
        let user2 = User(name: "Peter")
        let user3 = User(name: "Zynk")
        let sortDescriptor = SortDescriptor(\User.name)

        // Act
        try sut.add(user3)
        try sut.add(user1)
        try sut.add(user2)
        try sut.save()

        let fetchedUsers = try sut.fetchAll(
            type: User.self,
            sortedBy: [sortDescriptor]
        )

        // Assert
        #expect(fetchedUsers.count == 3)
        #expect(fetchedUsers[0] == user1)
        #expect(fetchedUsers[1] == user2)
        #expect(fetchedUsers[2] == user3)
    }
}
