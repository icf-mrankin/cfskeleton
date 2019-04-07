const merge = require('webpack-merge'); 
const common = require('./webpack.common.js'); 
const path = require('path'); 
const {WebpackWarPlugin} = require('webpack-war-plugin'); 
const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
 
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
        new CleanWebpackPlugin({
           // dry: true
        }),
        new MiniCssExtractPlugin({
            filename: 'static/[name].css'
        }),
        new WebpackWarPlugin({ 
            archiveName: 'ROOT', 
            webInf: './lucee_dist/WEB-INF', 
            additionalElements: [ 
                {path: 'wwwroot', destPath: '/'} 
            ] 
        }) 
    ],
    module: {
        rules: [
            {
                test: /\.(ttf|eot|svg|woff(2)?)(\?[a-z0-9=&.]+)?$/,
                use: [{
                    loader: 'file-loader',
                    options: {
                        name: 'static/[name].[ext]',
                        publicPath: '/static'
                    }
                }]
            }
        ]
    } 
}); 