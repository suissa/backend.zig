const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Database = struct {
    allocator: Allocator,
    connected: bool,

    pub fn init(allocator: Allocator) Database {
        return Database{
            .allocator = allocator,
            .connected = false,
        };
    }

    pub fn connect(self: *Database) !void {
        self.connected = true;
    }

    pub fn disconnect(self: *Database) void {
        self.connected = false;
    }

    pub fn isConnected(self: *const Database) bool {
        return self.connected;
    }

    pub fn query(self: *const Database, sql: []const u8) ![]u8 {
        if (!self.connected) {
            return error.NotConnected;
        }
        const result = try self.allocator.dupe(u8, sql);
        return result;
    }
};

test "Database connects successfully" {
    var db = Database.init(std.testing.allocator);
    try db.connect();
    try std.testing.expect(db.isConnected());
}

test "Database disconnects successfully" {
    var db = Database.init(std.testing.allocator);
    try db.connect();
    db.disconnect();
    try std.testing.expect(!db.isConnected());
}

test "Database query fails when not connected" {
    var db = Database.init(std.testing.allocator);
    try std.testing.expectError(error.NotConnected, db.query("SELECT 1"));
}

test "Database query succeeds when connected" {
    var db = Database.init(std.testing.allocator);
    defer db.allocator.free(db.query("SELECT 1") catch unreachable);
    try db.connect();
    const result = try db.query("SELECT 1");
    defer db.allocator.free(result);
    try std.testing.expectEqualStrings("SELECT 1", result);
}
