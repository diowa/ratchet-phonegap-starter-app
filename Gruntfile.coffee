module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    autoprefixer:
      options:
        browsers: ['Android 2', 'iOS 6']
      multiple_files:
        src: 'www/css/*.css'

    coffee:
      dist:
        files:
          'www/js/index.js': ['src/coffee/index.coffee', 'src/coffee/*.coffee']
          'www/spec/index.js': ['src/spec/index.coffee']

    exec:
      build:
        command: 'phonegap build android'
        stdout: true
        stderror: true

    haml:
      dist:
        files:
          'www/index.html': 'src/haml/index.haml'
          'www/two.html': 'src/haml/two.haml'
          'www/spec.html': 'src/spec/spec.haml'

    ripple:
      options:
        path: 'www'
        keepAlive: true
        open: true
        port: 4400

    sass:
      dist:
        files:
          'www/css/index.css': ['src/sass/index.scss']
          'www/css/theme-android.css': ['src/sass/theme-android.scss']
          'www/css/theme-ios.css': ['src/sass/theme-ios.scss']

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      build:
        src: 'src/<%= pkg.name %>.js',
        dest: 'build/<%= pkg.name %>.min.js'

    watch:
      options:
        interval: 5000
      coffee:
        files: ['src/coffee/*.coffee', 'src/spec/*.coffee']
        tasks: ['coffee']
      haml:
        files: ['src/haml/*.haml', 'src/spec/*.haml']
        tasks: ['haml']
      sass:
        files: ['src/sass/*.scss']
        tasks: ['sass', 'autoprefixer']
      www:
        files: ['www/css/*.css', 'www/**/*.html', 'www/**/*.js', 'www/**/*.jpg', 'www/**/*.png', 'www/**/*.gif'],
        tasks: ['exec:build']

    phonegap:
      config:
        root: 'www'
        config: 'www/config.xml'
        cordova: '.cordova'
        path: 'phonegap'
        plugins: []
        platforms: ['android']
        maxBuffer: 200 # You may need to raise this for iOS.
        verbose: false
        releases: 'releases'
        releaseName: ->
          pkg.name + '-' + pkg.version

        # Must be set for ios to work.
        # Should return the app name.
        name: ->
          pkg.name

        # Add a key if you plan to use the `release:android` task
        # See http://developer.android.com/tools/publishing/app-signing.html
        key:
          store: 'release.keystore'
          alias: 'release'
          aliasPassword: ->
            # Prompt, read an environment variable, or just embed as a string literal
            ''

          storePassword: ->
            # Prompt, read an environment variable, or just embed as a string literal
            ''

        # Set an app icon at various sizes (optional)
        icons:
          android:
            ldpi: 'icon-36-ldpi.png'
            mdpi: 'icon-48-mdpi.png'
            hdpi: 'icon-72-hdpi.png'
            xhdpi: 'icon-96-xhdpi.png'

          wp8:
            app: 'icon-62-tile.png'
            tile: 'icon-173-tile.png'

          ios:
            icon29: 'icon29.png'
            icon29x2: 'icon29x2.png'
            icon40: 'icon40.png'
            icon40x2: 'icon40x2.png'
            icon57: 'icon57.png'
            icon57x2: 'icon57x2.png'
            icon60x2: 'icon60x2.png'
            icon72: 'icon72.png'
            icon72x2: 'icon72x2.png'
            icon76: 'icon76.png'
            icon76x2: 'icon76x2.png'

        # Set a splash screen at various sizes (optional)
        # Only works for Android and IOS
        screens:
          android:
            ldpi: 'screen-ldpi-portrait.png'

            # landscape version
            ldpiLand: 'screen-ldpi-landscape.png'
            mdpi: 'screen-mdpi-portrait.png'

            # landscape version
            mdpiLand: 'screen-mdpi-landscape.png'
            hdpi: 'screen-hdpi-portrait.png'

            # landscape version
            hdpiLand: 'screen-hdpi-landscape.png'
            xhdpi: 'screen-xhdpi-portrait.png'

            # landscape version
            xhdpiLand: 'www/screen-xhdpi-landscape.png'

          ios:
            # ipad landscape
            ipadLand: 'screen-ipad-landscape.png'
            ipadLandx2: 'screen-ipad-landscape-2x.png'

            # ipad portrait
            ipadPortrait: 'screen-ipad-portrait.png'
            ipadPortraitx2: 'screen-ipad-portrait-2x.png'

            # iphone portrait
            iphonePortrait: 'screen-iphone-portrait.png'
            iphonePortraitx2: 'screen-iphone-portrait-2x.png'
            iphone568hx2: 'screen-iphone-568h-2x.png'

        # Android-only integer version to increase with each release.
        # See http://developer.android.com/tools/publishing/versioning.html
        versionCode: ->
          1

        # Android-only options that will override the defaults set by Phonegap in the
        # generated AndroidManifest.xml
        # See https://developer.android.com/guide/topics/manifest/uses-sdk-element.html
        minSdkVersion: ->
          10

        targetSdkVersion: ->
          19

        # iOS7-only options that will make the status bar white and transparent
        iosStatusBar: 'WhiteAndTransparent'

        # If you want to use the Phonegap Build service to build one or more
        # of the platforms specified above, include these options.
        # See https://build.phonegap.com/
        remote:
          username: 'your_username'
          password: 'your_password'
          platforms: [
            'android'
            'blackberry'
            'ios'
            'symbian'
            'webos'
            'wp7'
          ]

        # Set an explicit Android permissions list to override the automatic plugin defaults.
        # In most cases, you should omit this setting. See 'Android Permissions' in README.md for details.
        permissions: []

  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-haml'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-phonegap'

  grunt.registerTask 'compile-src', ['sass', 'autoprefixer', 'coffee', 'haml']
  grunt.registerTask 'dev', ['compile-src', 'exec:build', 'watch']
  grunt.registerTask 'build', ['compile-src', 'uglify', 'exec:build']

  grunt.registerTask 'default', 'dev'
