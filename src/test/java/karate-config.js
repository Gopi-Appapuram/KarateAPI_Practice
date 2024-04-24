function fn() {
  var env = 'e2e'; // Set environment to 'dev'
  var os = karate.os;
  karate.log('karate.env system property was:', env);
  karate.log("Your OS Is", os);

  var config = {
    env: env,
    baseUrl: 'http://localhost:8081',
    os: os
  };

  if (env == 'dev') {
    config.baseUrl = 'http://localhost:8081/api';
  } else if (env == 'e2e') {
    config.baseUrl = 'http://api.ipify.org/';
  }

  return config;
}
