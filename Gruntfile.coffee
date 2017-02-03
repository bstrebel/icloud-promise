module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    coffeelint:
      app: [
        "*.coffee"
        "test/**/*.coffee"
      ]
      options:
        no_trailing_whitespace:
          level: "ignore"
        max_line_length:
          value: 100
        indentation:
          value: 2
          level: "error"
        no_unnecessary_fat_arrows:
          level: 'ignore'

    mochaTest:
      test:
        options:
          timeout: 1000
          reporter: "spec"
          require: ['coffee-errors'] #needed for right line numbers in errors
        src: ["test/*.coffee"]
      coverage:
        options:
          reporter: "html-cov"
          quiet: true
          captureFile: "coverage.html"
        src: ["test/*"]

  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-mocha-test"

  grunt.registerTask "clean-coverage", ->
    fs = require "fs"
    path = require "path"

    replaceAll = (find, replace, str) ->
      escapeRegExp = (str) -> str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")
      str.replace(new RegExp(escapeRegExp(find), 'g'), replace)

    file = "#{__dirname}/coverage.html"
    html = fs.readFileSync(file).toString()
    html = replaceAll path.dirname(__dirname), "", html
    fs.writeFileSync file, html

  # Default task(s).
  grunt.registerTask "default", ["coffeelint", "mochaTest:test"]
  grunt.registerTask "test", ["coffeelint", "mochaTest:test"]
  grunt.registerTask "coverage",
    ["mochaTest:coverage", "clean-coverage"]
