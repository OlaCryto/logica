import type { ChannelPlugin, LogicaPluginApi } from "logica/plugin-sdk";
import { emptyPluginConfigSchema } from "logica/plugin-sdk";
import { ircPlugin } from "./src/channel.js";
import { setIrcRuntime } from "./src/runtime.js";

const plugin = {
  id: "irc",
  name: "IRC",
  description: "IRC channel plugin",
  configSchema: emptyPluginConfigSchema(),
  register(api: LogicaPluginApi) {
    setIrcRuntime(api.runtime);
    api.registerChannel({ plugin: ircPlugin as ChannelPlugin });
  },
};

export default plugin;
