const {defaults} = require('jest-config');

module.exports = {
    moduleFileExtensions: [...defaults.moduleFileExtensions, "d.ts"],
    moduleDirectories: [...defaults.moduleDirectories, "src"],
}