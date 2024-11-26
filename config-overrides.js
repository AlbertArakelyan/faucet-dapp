/**
 * FOR FIXING WEBPACK V5 ISSUES
 * 
 * BREAKING CHANGE: webpack < 5 used to include polyfills for node.js core modules by default.
 * This is no longer the case. Verify if you need this module and configure a polyfill for it.
 * 
 * Also scripts "start", "build" and "test" are using "react-app-rewired"
 * And many native for node packages installed as dev dependencies for browser
 * The can be found here:
 * https://stackoverflow.com/questions/64557638/how-to-polyfill-node-core-modules-in-webpack-5 
 */

const webpack = require("webpack");

module.exports = function override(config) {
  const fallback = config.resolve.fallback || {};
  Object.assign(fallback, {
    crypto: require.resolve("crypto-browserify"),
    stream: require.resolve("stream-browserify"),
    assert: require.resolve("assert"),
    http: require.resolve("stream-http"),
    https: require.resolve("https-browserify"),
    os: require.resolve("os-browserify"),
    url: require.resolve("url"),
    path: require.resolve("path-browserify"),
  });
  config.resolve.fallback = fallback;
  config.plugins = (config.plugins || []).concat([
    new webpack.ProvidePlugin({
      process: "process/browser",
      Buffer: ["buffer", "Buffer"],
    }),
  ]);
  return config;
};
