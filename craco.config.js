const cracoPureScriptLoader = require("craco-purescript-loader");

module.exports = {
    plugins: [
        {
            plugin: cracoPureScriptLoader,
            options: {
                spago: true,
                watch: true,
                pscIde: false,
            },
        },
    ],
    babel: {
        presets: ['@babel/preset-react']
    },
    jest: {
        configure: (jestConfig) => { jestConfig.moduleFileExtensions.push("d.ts"); return jestConfig; },
    },
}