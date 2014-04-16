# Ratchet PhoneGap Starter App

![Screenshot](http://i57.tinypic.com/15gp0dj.png)

This is a simple starter application using the following technologies:

* [PhoneGap 3.4.0][1]
* [Ripple Emulator][2]
* [Grunt][3]
* [Ratchet][4]
* [HAML][5]
* [Sass][6]
* [CoffeeScript][7]
* [Autoprefixer][8]

 [1]: http://phonegap.com/
 [2]: http://ripple.incubator.apache.org/
 [3]: http://gruntjs.com/
 [4]: http://goratchet.com/
 [5]: http://haml.info/
 [6]: http://sass-lang.com/
 [7]: http://coffeescript.org/
 [8]: https://github.com/ai/autoprefixer



## Prerequisites

```sh
$ npm install -g phonegap grunt-cli ripple-emulator
```



## Setup

### 1. Clone this repository

```sh
$ git clone https://github.com/diowa/ratchet-phonegap-starter-app.git my-app
```


### 2. Build your application for specific platform

```sh
$ cd my-app
$ phonegap build android
```


### 3. Install node dependencies

```sh
$ npm install
```


### 4. Start Grunt

```sh
$ grunt
```


### 5. Start Ripple

```sh
$ ripple emulate
```



## Development Guide

By default, Ripple emulator starts on `http://localhost:4400/?enableripple=cordova-3.0.0`

Work in the `/src` folder with haml, scss and coffee files (HTML, CSS and JavaScript files will be automatically compiled into the `/www` folder).

If you need extra `.haml` and `.scss` files, remember to add them in the `Gruntfile.coffee` (it is not required for CoffeeScript files). In the following example, we are going to add `settings.haml` and `theme-wp.scss`

```coffee
# [...]
haml:
  dist:
    files:
      'www/index.html': 'src/haml/index.haml'
      'www/two.html': 'src/haml/two.haml'
      'www/spec.html': 'src/spec/spec.haml'
      'www/settings.html': 'src/haml/settings.haml'
# [...]
sass:
  dist:
    files:
      'www/css/index.css': ['src/sass/index.scss']
      'www/css/theme-android.css': ['src/sass/theme-android.scss']
      'www/css/theme-ios.css': ['src/sass/theme-ios.scss']
      'www/css/theme-wp.css': ['src/sass/theme-wp.scss']
# [...]
```

## Authors

**Geremia Taglialatela**

+ http://github.com/tagliala
+ http://twitter.com/gtagliala

**Cesidio Di Landa**

+ http://github.com/cesidio
+ http://twitter.com/cesid


## Contributing

**Early Contributors: push against master branch until version is 0.0.0**

Please read through our [contributing guidelines](CONTRIBUTING.md). Included are directions for opening issues, coding standards, and notes on development.


## Copyright and license

**Ratchet Phonegap Starter App** is licensed under the BSD 2-Clause License

Check the LICENSE file for more information



## Thanks

Special thanks to all developers of open source libraries used in this project.
