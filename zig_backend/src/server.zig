const std = @import("std");

pub const Server = struct {
    port: u16,

    pub fn init(port: u16) Server {
        return Server{ .port = port };
    }

    pub fn start(self: *const Server) !void {
        const addr = try std.net.Address.parseIp4("127.0.0.1", self.port);
        const listener = try std.posix.socket(addr.any.family, std.posix.SOCK.STREAM, 0);
        defer std.posix.close(listener);

        try std.posix.bind(listener, &addr.any, addr.getOsSockLen());
        try std.posix.listen(listener, 128);

        std.debug.print("Server listening on port {d}\n", .{self.port});

        while (true) {
            const client = std.posix.accept(listener, null, null, 0) catch continue;
            _ = client;
        }
    }
};

pub fn main() !void {
    var server = Server.init(8080);
    try server.start();
}
