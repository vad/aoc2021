const std = @import("std");
const input = @embedFile("input1");

pub fn main() anyerror!void {
    var it = std.mem.tokenize(u8, input, "\n");

    var prev: i128 = std.math.maxInt(i128);
    var counter: u64 = 0;
    while (it.next()) |line| {
        // std.log.info("{s}", .{line});

        var current = try std.fmt.parseInt(i128, line, 10);
        // std.log.info("{}", .{current});
        if (current > prev) {
            counter += 1;
        }
        prev = current;
    }
    std.log.info("Result: {}", .{counter});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
