let Caf = require("caffeine-script-runtime");
Caf.defMod(module, () => {
  return {
    compile: function(source, options) {
      let Parser = require("./Parser");
      return {
        compiled: {
          js: Parser.parse(source, options).getStn().transform().toJsModule()
        }
      };
    }
  };
});