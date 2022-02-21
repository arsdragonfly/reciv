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
        {
            plugin: {
                overrideJestConfig: ({ jestConfig }) => {
                    jestConfig.moduleNameMapper = {
                        ...jestConfig.moduleNameMapper,
                        "purs/(.*)": "<rootDir>/output/$1/index.js",
                    }
                    return jestConfig
                }
            }
        }
    ],
    babel: {
        presets: ['@babel/preset-react']
    },
}