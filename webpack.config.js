const path = require( "path" );

module.exports = {
  // webpack folder's entry js - excluded from jekll's build process.
  entry: "./webpack/entry.js",
  output: {
    // we're going to put the generated file in the assets folder so jekyll will grab it.
      path: path.resolve( __dirname, 'assets/js/webpack/' ),
      filename: "bundle.js"
  },
  module: {
    rules: [
//      {
//        test: /\.jsx?$/,
//        exclude: /(node_modules)/,
//        loader: 'babel-loader',
//        query: {
//          presets: ['react', 'es2015']
//        }
//      },

//        exclude: /(node_modules)/,

      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
//          'postcss-loader'
        ]
      },
/*
      { 
				// https://github.com/webpack-contrib/css-loader/issues/38
        test: /\.(woff|woff(2)?|eot|ttf|svg)(\?[a-z0-9=.]+)?$/, 
        loader: 'url-loader?limit=100000'
      }
*/
      {
        test: /\.(png|svg|jpg|gif)$/,
        use: [
          'file-loader'
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
