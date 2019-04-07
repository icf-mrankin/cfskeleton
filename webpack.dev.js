const merge = require('webpack-merge'); 
const common = require('./webpack.common.js'); 
const path = require('path'); 
const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
 
console.log('\033[44m'); 
console.log("  ___           __      __     _      _    "); 
console.log(" |   \\ _____ __ \\ \\    / /__ _| |_ __| |_  "); 
console.log(" | |) / -_) V /  \\ \\/\\/ // _` |  _/ _| ' \\ "); 
console.log(" |___/\\___|\\_/    \\_/\\_/ \\__,_|\\__\\__|_||_|"); 
console.log('\033[0m'); 
 
module.exports = merge(common, { 
    mode: 'development', 
    output: { 
            path: path.resolve(__dirname, 'wwwroot/static'), 
            filename: '[name].js', 
        }, 
    plugins: [
	    new CleanWebpackPlugin({
				//dry: true
			}),
			new MiniCssExtractPlugin({
				filename: '[name].css'
			})
    ],
    module: {
    	rules: [
				{
					test: /\.(ttf|eot|svg|woff(2)?)(\?[a-z0-9=&.]+)?$/,
					use: [{
						loader: 'file-loader',
						options: {
							name: '[name].[ext]',
							publicPath: '/static'
						}
					}]
				}
    	]
    }
}); 