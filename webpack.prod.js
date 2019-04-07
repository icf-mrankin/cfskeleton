const merge = require('webpack-merge'); 
const common = require('./webpack.common.js'); 
const path = require('path'); 
const {WebpackWarPlugin} = require('webpack-war-plugin'); 
 
 
console.log('\033[42m'); 
console.log("  ___            _         _   _            ___      _ _    _ "); 
console.log(" | _ \\_ _ ___ __| |_  _ __| |_(_)___ _ _   | _ )_  _(_) |__| |"); 
console.log(" |  _/ '_/ _ | _` | || / _|  _| / _ \\ ' \\  | _ \\ || | | / _` |"); 
console.log(" |_| |_| \\___|__,_|\\_,_\\__|\\__|_\\___/_||_| |___/\\_,_|_|_\\__,_|"); 
console.log('\033[0m'); 
 
module.exports = merge(common, { 
    mode: 'production', 
    output: { 
            path: path.resolve(__dirname, 'build'), 
            filename: 'static/[name].js', 
        }, 
    plugins: [ 
        new WebpackWarPlugin({ 
            archiveName: 'ROOT', 
            webInf: './lucee_dist/WEB-INF', 
            additionalElements: [ 
                {path: 'wwwroot', destPath: '/'} 
            ] 
        }) 
    ] 
}); 