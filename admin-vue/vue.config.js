'use strict';
const path = require('path');

function resolve(dir) {
  return path.join(__dirname, dir);
}

const CompressionPlugin = require('compression-webpack-plugin');

const name = process.env.VUE_APP_TITLE || 'fuint汽车会员系统';

const port = process.env.port || process.env.npm_config_port || 81;

const serverUrl = process.env.VUE_APP_SERVER_URL || 'https://www.fuint.cn';

module.exports = {
  publicPath: process.env.VUE_APP_PUBLIC_PATH,
  outputDir: 'dist',
  assetsDir: 'static',
  lintOnSave: false,
  productionSourceMap: false,
  devServer: {
    host: '0.0.0.0',
    port: port,
    open: true,
    proxy: {
      '/backendApi': {
        target: serverUrl,
        changeOrigin: true,
        ws: true,
        pathRewrite: serverUrl.includes('localhost') ? {} : { '^/backendApi': '/fuint-car/backendApi' },
      },
      '/clientApi': {
        target: serverUrl,
        changeOrigin: true,
        ws: true,
        pathRewrite: serverUrl.includes('localhost') ? {} : { '^/clientApi': '/fuint-car/clientApi' },
      },
    },
    disableHostCheck: true,
  },
  css: {
    loaderOptions: {
      sass: {
        sassOptions: { outputStyle: 'expanded' },
      },
    },
  },
  configureWebpack: {
    resolve: {
      fallback: {
        path: require.resolve('path-browserify'),
        buffer: require.resolve('buffer'),
        stream: require.resolve('stream-browserify'),
        crypto: require.resolve('crypto-browserify'),
        assert: require.resolve('assert'),
        http: require.resolve('stream-http'),
        https: require.resolve('https-browserify'),
        os: require.resolve('os-browserify/browser'),
        url: require.resolve('url'),
      },
    },
    name: name,
    resolve: {
      alias: {
        '@': resolve('src'),
      },
    },
    plugins:
      process.env.NODE_ENV === 'production'
        ? [
            new CompressionPlugin({
              test: /\.(js|css|html)?$/i,
              filename: '[path][base].gz',
              algorithm: 'gzip',
              threshold: 10240,
              minRatio: 0.8,
            }),
          ]
        : [],
  },
  chainWebpack(config) {
    config.plugins.delete('preload');
    config.plugins.delete('prefetch');

    config.module.rule('svg').exclude.add(resolve('src/assets/icons')).end();
    config.module
      .rule('icons')
      .test(/\.svg$/)
      .include.add(resolve('src/assets/icons'))
      .end()
      .use('svg-sprite-loader')
      .loader('svg-sprite-loader')
      .options({
        symbolId: 'icon-[name]',
      })
      .end();

    config.when(process.env.NODE_ENV !== 'development', (config) => {
      config
        .plugin('ScriptExtHtmlWebpackPlugin')
        .after('html')
        .use('script-ext-html-webpack-plugin', [
          {
            inline: /runtime\..*\.js$/,
          },
        ])
        .end();
      config.optimization.splitChunks({
        chunks: 'all',
        cacheGroups: {
          libs: {
            name: 'chunk-libs',
            test: /[\\/]node_modules[\\/]/,
            priority: 10,
            chunks: 'initial',
          },
          elementUI: {
            name: 'chunk-elementUI',
            priority: 20,
            test: /[\\/]node_modules[\\/]_?element-ui(.*)/,
          },
          commons: {
            name: 'chunk-commons',
            test: resolve('src/components'),
            minChunks: 3,
            priority: 5,
            reuseExistingChunk: true,
          },
        },
      });
      config.optimization.runtimeChunk('single');
    });
  },
};
