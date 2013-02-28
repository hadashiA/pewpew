module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      files:
        'app.js': 'app.coffee',
        'public/javascripts/app.js': ['src/client/**/*.coffee']
      glob_to_multipl: 
        expand: true
        cwd: 'src/server'
        src: ['**/*.coffee']
        dest: 'lib/'
        ext: '.js'

    concat:
      options:
        separator: ";"
      vendor:
        src: [
          'components/underscore/underscore-min.js',
          'components/jquery/jquery.min.js'
          ],
        dest: "public/javascripts/vendor.js"
      app:
        src: ["public/javascripts/lib/**/*.js"]
        dest: "public/javascripts/app.js"

    watch:
      files: 'src/**/*.coffee'
      tasks: ['coffee', 'concat']

  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask 'default', ['coffee', 'concat']