
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
}