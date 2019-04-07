const merge = require('webpack-merge'); 
const common = require('./webpack.common.js'); 
const path = require('path'); 
 
console.log('\033[44m'); 
console.log("  ___           __      __     _      _    "); 
console.log(" |   \\ _____ __ \\ \\    / /__ _| |_ __| |_  "); 
console.log(" | |) / -_) V /  \\ \\/\\/ // _` |  _/ _| ' \\ "); 
console.log(" |___/\\___|\\_/    \\_/\\_/ \\__,_|\\__\\__|_||_|"); 
console.log('\033[0m'); 
 
module.exports = merge(common, { 
    mode: 'development', 
    output: { 
            path: path.resolve(__dirname, 'wwwroot'), 
            filename: 'static/[name].js', 
        }, 
}); 