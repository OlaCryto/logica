import type {
  AnyAgentTool,
  LogicaPluginApi,
  LogicaPluginToolFactory,
} from "../../src/plugins/types.js";
import { createLobsterTool } from "./src/lobster-tool.js";

export default function register(api: LogicaPluginApi) {
  api.registerTool(
    ((ctx) => {
      if (ctx.sandboxed) {
        return null;
      }
      return createLobsterTool(api) as AnyAgentTool;
    }) as LogicaPluginToolFactory,
    { optional: true },
  );
}
