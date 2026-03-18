import { describe, expect, it } from "vitest";
import { resolveIrcInboundTarget } from "./monitor.js";

describe("irc monitor inbound target", () => {
  it("keeps channel target for group messages", () => {
    expect(
      resolveIrcInboundTarget({
        target: "#logica",
        senderNick: "alice",
      }),
    ).toEqual({
      isGroup: true,
      target: "#logica",
      rawTarget: "#logica",
    });
  });

  it("maps DM target to sender nick and preserves raw target", () => {
    expect(
      resolveIrcInboundTarget({
        target: "logica-bot",
        senderNick: "alice",
      }),
    ).toEqual({
      isGroup: false,
      target: "alice",
      rawTarget: "logica-bot",
    });
  });

  it("falls back to raw target when sender nick is empty", () => {
    expect(
      resolveIrcInboundTarget({
        target: "logica-bot",
        senderNick: " ",
      }),
    ).toEqual({
      isGroup: false,
      target: "logica-bot",
      rawTarget: "logica-bot",
    });
  });
});
