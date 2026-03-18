import path from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import { resolveStorePath } from "./paths.js";

describe("resolveStorePath", () => {
  afterEach(() => {
    vi.unstubAllEnvs();
  });

  it("uses LOGICA_HOME for tilde expansion", () => {
    vi.stubEnv("LOGICA_HOME", "/srv/logica-home");
    vi.stubEnv("HOME", "/home/other");

    const resolved = resolveStorePath("~/.logica/agents/{agentId}/sessions/sessions.json", {
      agentId: "research",
    });

    expect(resolved).toBe(
      path.resolve("/srv/logica-home/.logica/agents/research/sessions/sessions.json"),
    );
  });
});
