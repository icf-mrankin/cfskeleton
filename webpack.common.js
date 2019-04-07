const path = require('path');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
	entry: {
		app: './src/js/app.js'
	},
	output: {
		path: path.resolve(__dirname,'wwwroot/static')
	},
	plugins: [
		new CleanWebpackPlugin({
			dry: true
		}),
		new MiniCssExtractPlugin({
			filename: 'static/[name].css',
		}),
	],
	module: {
		rules: [
			{
				test: require.resolve('jquery'),
				use: [{
					loader: 'expose-loader',
					options: '$'
				},{
					loader: 'expose-loader',
					options: 'jQuery'
				}]
			},
			{
				test: require.resolve('inputmask'),
				use: [{
					loader: 'expose-loader',
					options: 'inputmask'
				}]
			},
			{
				test: require.resolve('qrcode'),
				use: [{
					loader: 'expose-loader',
					options: 'qrcode'
				}]
			},
			{
				test: /\.(sa|sc|c)ss$/,
				use: [
					MiniCssExtractPlugin.loader,
					'css-loader',
					{
						loader: 'postcss-loader',
						options: {
							plugins: function() {
								return [
									require('autoprefixer')
								];
							}
						}
					},
					'sass-loader',
				]
			},
			{
				test: /\.(ttf|eot|svg|woff(2)?)(\?[a-z0-9=&.]+)?$/,
				use: [{
					loader: 'file-loader',
					options: {
						name: '[name].[ext]',
						outputPath: 'static',
						publicPath: '/static'
					}
				}]
			}
		]
	}
};

