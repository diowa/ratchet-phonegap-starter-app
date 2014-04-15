# Ratchet Phonegap Starter App

This is a simple starter application using the following technologies:

* [Phonegap][1]
* [Ratchet][2]
* [Grunt][3]
* [CoffeeScript][4]
* [Sass][5]
* [HAML][6]
* [Ripple][7]

 [1]: http://phonegap.com/
 [2]: http://goratchet.com/
 [3]: http://gruntjs.com/
 [4]: http://coffeescript.org/
 [5]: http://sass-lang.com/
 [6]: http://haml.info/
 [7]: http://ripple.incubator.apache.org/



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

Edit all your files inside the `src` folder. JavaScripts, HTML and CSS will be automatically compiled into the `www` folder.

If you need extra `haml` and `scss` files, remember to edit `Gruntfile.coffee`.



## Authors

**Geremia Taglialatela**

+ http://github.com/tagliala
+ http://twitter.com/gtagliala

**Cesidio Di Landa**

+ http://github.com/cesidio
+ http://twitter.com/cesid



## Copyright and license

**Ratchet Phonegap Starter App** is licensed under the BSD 2-Clause License

Check the LICENSE file for more information



## Thanks

Special thanks to all developers of open source libraries used in this project.
