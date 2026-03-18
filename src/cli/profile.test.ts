import path from "node:path";
import { describe, expect, it } from "vitest";
import { formatCliCommand } from "./command-format.js";
import { applyCliProfileEnv, parseCliProfileArgs } from "./profile.js";

describe("parseCliProfileArgs", () => {
  it("leaves gateway --dev for subcommands", () => {
    const res = parseCliProfileArgs([
      "node",
      "logica",
      "gateway",
      "--dev",
      "--allow-unconfigured",
    ]);
    if (!res.ok) {
      throw new Error(res.error);
    }
    expect(res.profile).toBeNull();
    expect(res.argv).toEqual(["node", "logica", "gateway", "--dev", "--allow-unconfigured"]);
  });

  it("still accepts global --dev before subcommand", () => {
    const res = parseCliProfileArgs(["node", "logica", "--dev", "gateway"]);
    if (!res.ok) {
      throw new Error(res.error);
    }
    expect(res.profile).toBe("dev");
    expect(res.argv).toEqual(["node", "logica", "gateway"]);
  });

  it("parses --profile value and strips it", () => {
    const res = parseCliProfileArgs(["node", "logica", "--profile", "work", "status"]);
    if (!res.ok) {
      throw new Error(res.error);
    }
    expect(res.profile).toBe("work");
    expect(res.argv).toEqual(["node", "logica", "status"]);
  });

  it("rejects missing profile value", () => {
    const res = parseCliProfileArgs(["node", "logica", "--profile"]);
    expect(res.ok).toBe(false);
  });

  it("rejects combining --dev with --profile (dev first)", () => {
    const res = parseCliProfileArgs(["node", "logica", "--dev", "--profile", "work", "status"]);
    expect(res.ok).toBe(false);
  });

  it("rejects combining --dev with --profile (profile first)", () => {
    const res = parseCliProfileArgs(["node", "logica", "--profile", "work", "--dev", "status"]);
    expect(res.ok).toBe(false);
  });
});

describe("applyCliProfileEnv", () => {
  it("fills env defaults for dev profile", () => {
    const env: Record<string, string | undefined> = {};
    applyCliProfileEnv({
      profile: "dev",
      env,
      homedir: () => "/home/peter",
    });
    const expectedStateDir = path.join(path.resolve("/home/peter"), ".logica-dev");
    expect(env.LOGICA_PROFILE).toBe("dev");
    expect(env.LOGICA_STATE_DIR).toBe(expectedStateDir);
    expect(env.LOGICA_CONFIG_PATH).toBe(path.join(expectedStateDir, "logica.json"));
    expect(env.LOGICA_GATEWAY_PORT).toBe("19001");
  });

  it("does not override explicit env values", () => {
    const env: Record<string, string | undefined> = {
      LOGICA_STATE_DIR: "/custom",
      LOGICA_GATEWAY_PORT: "19099",
    };
    applyCliProfileEnv({
      profile: "dev",
      env,
      homedir: () => "/home/peter",
    });
    expect(env.LOGICA_STATE_DIR).toBe("/custom");
    expect(env.LOGICA_GATEWAY_PORT).toBe("19099");
    expect(env.LOGICA_CONFIG_PATH).toBe(path.join("/custom", "logica.json"));
  });

  it("uses LOGICA_HOME when deriving profile state dir", () => {
    const env: Record<string, string | undefined> = {
      LOGICA_HOME: "/srv/logica-home",
      HOME: "/home/other",
    };
    applyCliProfileEnv({
      profile: "work",
      env,
      homedir: () => "/home/fallback",
    });

    const resolvedHome = path.resolve("/srv/logica-home");
    expect(env.LOGICA_STATE_DIR).toBe(path.join(resolvedHome, ".logica-work"));
    expect(env.LOGICA_CONFIG_PATH).toBe(
      path.join(resolvedHome, ".logica-work", "logica.json"),
    );
  });
});

describe("formatCliCommand", () => {
  it("returns command unchanged when no profile is set", () => {
    expect(formatCliCommand("logica doctor --fix", {})).toBe("logica doctor --fix");
  });

  it("returns command unchanged when profile is default", () => {
    expect(formatCliCommand("logica doctor --fix", { LOGICA_PROFILE: "default" })).toBe(
      "logica doctor --fix",
    );
  });

  it("returns command unchanged when profile is Default (case-insensitive)", () => {
    expect(formatCliCommand("logica doctor --fix", { LOGICA_PROFILE: "Default" })).toBe(
      "logica doctor --fix",
    );
  });

  it("returns command unchanged when profile is invalid", () => {
    expect(formatCliCommand("logica doctor --fix", { LOGICA_PROFILE: "bad profile" })).toBe(
      "logica doctor --fix",
    );
  });

  it("returns command unchanged when --profile is already present", () => {
    expect(
      formatCliCommand("logica --profile work doctor --fix", { LOGICA_PROFILE: "work" }),
    ).toBe("logica --profile work doctor --fix");
  });

  it("returns command unchanged when --dev is already present", () => {
    expect(formatCliCommand("logica --dev doctor", { LOGICA_PROFILE: "dev" })).toBe(
      "logica --dev doctor",
    );
  });

  it("inserts --profile flag when profile is set", () => {
    expect(formatCliCommand("logica doctor --fix", { LOGICA_PROFILE: "work" })).toBe(
      "logica --profile work doctor --fix",
    );
  });

  it("trims whitespace from profile", () => {
    expect(formatCliCommand("logica doctor --fix", { LOGICA_PROFILE: "  jblogica  " })).toBe(
      "logica --profile jblogica doctor --fix",
    );
  });

  it("handles command with no args after logica", () => {
    expect(formatCliCommand("logica", { LOGICA_PROFILE: "test" })).toBe(
      "logica --profile test",
    );
  });

  it("handles pnpm wrapper", () => {
    expect(formatCliCommand("pnpm logica doctor", { LOGICA_PROFILE: "work" })).toBe(
      "pnpm logica --profile work doctor",
    );
  });
});
