import { describe, expect, it } from "vitest";
import {
  buildParseArgv,
  getFlagValue,
  getCommandPath,
  getPrimaryCommand,
  getPositiveIntFlagValue,
  getVerboseFlag,
  hasHelpOrVersion,
  hasFlag,
  shouldMigrateState,
  shouldMigrateStateFromPath,
} from "./argv.js";

describe("argv helpers", () => {
  it("detects help/version flags", () => {
    expect(hasHelpOrVersion(["node", "logica", "--help"])).toBe(true);
    expect(hasHelpOrVersion(["node", "logica", "-V"])).toBe(true);
    expect(hasHelpOrVersion(["node", "logica", "status"])).toBe(false);
  });

  it("extracts command path ignoring flags and terminator", () => {
    expect(getCommandPath(["node", "logica", "status", "--json"], 2)).toEqual(["status"]);
    expect(getCommandPath(["node", "logica", "agents", "list"], 2)).toEqual(["agents", "list"]);
    expect(getCommandPath(["node", "logica", "status", "--", "ignored"], 2)).toEqual(["status"]);
  });

  it("returns primary command", () => {
    expect(getPrimaryCommand(["node", "logica", "agents", "list"])).toBe("agents");
    expect(getPrimaryCommand(["node", "logica"])).toBeNull();
  });

  it("parses boolean flags and ignores terminator", () => {
    expect(hasFlag(["node", "logica", "status", "--json"], "--json")).toBe(true);
    expect(hasFlag(["node", "logica", "--", "--json"], "--json")).toBe(false);
  });

  it("extracts flag values with equals and missing values", () => {
    expect(getFlagValue(["node", "logica", "status", "--timeout", "5000"], "--timeout")).toBe(
      "5000",
    );
    expect(getFlagValue(["node", "logica", "status", "--timeout=2500"], "--timeout")).toBe(
      "2500",
    );
    expect(getFlagValue(["node", "logica", "status", "--timeout"], "--timeout")).toBeNull();
    expect(getFlagValue(["node", "logica", "status", "--timeout", "--json"], "--timeout")).toBe(
      null,
    );
    expect(getFlagValue(["node", "logica", "--", "--timeout=99"], "--timeout")).toBeUndefined();
  });

  it("parses verbose flags", () => {
    expect(getVerboseFlag(["node", "logica", "status", "--verbose"])).toBe(true);
    expect(getVerboseFlag(["node", "logica", "status", "--debug"])).toBe(false);
    expect(getVerboseFlag(["node", "logica", "status", "--debug"], { includeDebug: true })).toBe(
      true,
    );
  });

  it("parses positive integer flag values", () => {
    expect(getPositiveIntFlagValue(["node", "logica", "status"], "--timeout")).toBeUndefined();
    expect(
      getPositiveIntFlagValue(["node", "logica", "status", "--timeout"], "--timeout"),
    ).toBeNull();
    expect(
      getPositiveIntFlagValue(["node", "logica", "status", "--timeout", "5000"], "--timeout"),
    ).toBe(5000);
    expect(
      getPositiveIntFlagValue(["node", "logica", "status", "--timeout", "nope"], "--timeout"),
    ).toBeUndefined();
  });

  it("builds parse argv from raw args", () => {
    const nodeArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["node", "logica", "status"],
    });
    expect(nodeArgv).toEqual(["node", "logica", "status"]);

    const versionedNodeArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["node-22", "logica", "status"],
    });
    expect(versionedNodeArgv).toEqual(["node-22", "logica", "status"]);

    const versionedNodeWindowsArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["node-22.2.0.exe", "logica", "status"],
    });
    expect(versionedNodeWindowsArgv).toEqual(["node-22.2.0.exe", "logica", "status"]);

    const versionedNodePatchlessArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["node-22.2", "logica", "status"],
    });
    expect(versionedNodePatchlessArgv).toEqual(["node-22.2", "logica", "status"]);

    const versionedNodeWindowsPatchlessArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["node-22.2.exe", "logica", "status"],
    });
    expect(versionedNodeWindowsPatchlessArgv).toEqual(["node-22.2.exe", "logica", "status"]);

    const versionedNodeWithPathArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["/usr/bin/node-22.2.0", "logica", "status"],
    });
    expect(versionedNodeWithPathArgv).toEqual(["/usr/bin/node-22.2.0", "logica", "status"]);

    const nodejsArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["nodejs", "logica", "status"],
    });
    expect(nodejsArgv).toEqual(["nodejs", "logica", "status"]);

    const nonVersionedNodeArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["node-dev", "logica", "status"],
    });
    expect(nonVersionedNodeArgv).toEqual(["node", "logica", "node-dev", "logica", "status"]);

    const directArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["logica", "status"],
    });
    expect(directArgv).toEqual(["node", "logica", "status"]);

    const bunArgv = buildParseArgv({
      programName: "logica",
      rawArgs: ["bun", "src/entry.ts", "status"],
    });
    expect(bunArgv).toEqual(["bun", "src/entry.ts", "status"]);
  });

  it("builds parse argv from fallback args", () => {
    const fallbackArgv = buildParseArgv({
      programName: "logica",
      fallbackArgv: ["status"],
    });
    expect(fallbackArgv).toEqual(["node", "logica", "status"]);
  });

  it("decides when to migrate state", () => {
    expect(shouldMigrateState(["node", "logica", "status"])).toBe(false);
    expect(shouldMigrateState(["node", "logica", "health"])).toBe(false);
    expect(shouldMigrateState(["node", "logica", "sessions"])).toBe(false);
    expect(shouldMigrateState(["node", "logica", "memory", "status"])).toBe(false);
    expect(shouldMigrateState(["node", "logica", "agent", "--message", "hi"])).toBe(false);
    expect(shouldMigrateState(["node", "logica", "agents", "list"])).toBe(true);
    expect(shouldMigrateState(["node", "logica", "message", "send"])).toBe(true);
  });

  it("reuses command path for migrate state decisions", () => {
    expect(shouldMigrateStateFromPath(["status"])).toBe(false);
    expect(shouldMigrateStateFromPath(["agents", "list"])).toBe(true);
  });
});
