
module.exports = {
    plugins: [
        {
            plugin: require('./craco-purescript-loader.config'),
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
    }
}