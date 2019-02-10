
const path 	= require( "path" );

var webpack = require( "webpack" );

const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const dev_mode = process.env.NODE_ENV !== 'production'



module.exports = {
	mode: "development", // or "production"

  // webpack folder's entry js - excluded from jekll's build process.
  entry: "./webpack/entry.js",
  output: {
		// we're going to put the generated file in the assets folder so jekyll will grab it.
		/* path: path.resolve( __dirname, 'assets/js/webpack/' ), */
		path: path.resolve( __dirname, 'webpack-bundle/' ),
		filename: "bundle.js"
  },
	plugins: [
		new webpack.ProvidePlugin( {
			$: 'jquery',
			jQuery: 'jquery',
			'window.$': 'jquery',
			'window.jQuery': 'jquery'   // for fancybox
		} ),
		new MiniCssExtractPlugin({
      // Options similar to the same options in webpackOptions.output
      // both options are optional
      filename:      dev_mode ? '[name].css' : '[name].[hash].css',
      chunkFilename: dev_mode ? '[id].css'   : '[id].[hash].css',
		})
	],
  module: {
    rules: [
			{
				test: /\.scss$/,
				use: [
					// style-loader: creates style nodes from JS strings
					//  - fallback to style-loader in development. 
					//  - use extract plugin to write to a dedicated file, for production.
					dev_mode ? 'style-loader' : MiniCssExtractPlugin.loader,

					"css-loader", // translates CSS into CommonJS
					"sass-loader" // compiles Sass to CSS, using Node Sass by default
				]
			},
      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
          //'postcss-loader'
        ]
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        use: [
          'url-loader'
        ]
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/,
        use: [
          'file-loader'
        ]
      },
      {
        test: /\.(csv|tsv)$/,
        use: [
          'csv-loader'
        ]
      },
      {
        test: /\.xml$/,
        use: [
          'xml-loader'
        ]
      }

    ]
  }
};


