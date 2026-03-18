import type { AnyAgentTool, LogicaPluginApi } from "../../src/plugins/types.js";
import { createLlmTaskTool } from "./src/llm-task-tool.js";

export default function register(api: LogicaPluginApi) {
  api.registerTool(createLlmTaskTool(api) as unknown as AnyAgentTool, { optional: true });
}
