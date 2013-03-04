module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      server:
        files: [
          {
            'app.js': 'app.coffee'
          }, {
            expand: true
            cwd: 'src/server'
            src: ['**/*.coffee']
            dest: 'lib/'
            ext: '.js'
          }
        ]
      client:
        options:
          bare: false
        files: [
          {
            expand: true,
            cwd: 'src/client'
            src: ['*.coffee']
            dest: 'public/js/lib/'
            ext: '.js'
          }
        ]

    concat:
      options:
        separator: ";"
      vendor:
        src: [
          'components/underscore/underscore-min.js'
          'components/jquery/jquery.min.js'
          'components/backbone/backbone-min.js'
          'components/hogan/web/builds/2.0.0/hogan-2.0.0.js'
          ],
        dest: "public/js/vendor.js"
      app:
        src: ["public/js/lib/**/*.js"]
        dest: "public/js/app.js"

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      app:
        files:
          'public/js/app.min.js': ['<%= concat.app.dest %>']

    watch:
      src_server:
        files: ['app.coffee', 'src/server/**/*.coffee']
        tasks: ['coffee:server']
      src_client:
        files: ['src/client/**/*.coffee']
        tasks: ['coffee:client', 'concat:app']

  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask 'default', ['coffee', 'concat', 'uglify']
  grunt.registerTask 'server', ['coffee:server']
  grunt.registerTask 'client', ['coffee:client', 'concat:app']