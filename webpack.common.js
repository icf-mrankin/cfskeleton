const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
	entry: {
		app: './src/js/app.js'
	},
	module: {
		rules: [
			{
				test: /\.(png|jpg|gif)$/,
				use: [{
						loader: 'file-loader',
						options: {
							outputpath: 'static',
							name: '[name].[ext]'
						}
				}]
			},
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
			}
		]
	}
};

