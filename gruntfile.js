
/*
# Grunt Config
This serves as the main configuration file for grunt.
It controls the different tasks.
Unfortunately, it also doesn"t get along well with dox our documentation
engine, because dox doesn"t handle comment like syntax in strings
very well, and chokes on it.
*/

module.exports = function(grunt) {
  grunt.initConfig({
    stylus: {
      compile: {
        options: {
          paths: ["assets/css/**/*.styl"],
        },
        files: {
          "css/bingo.css": "assets/css/bingo.styl" // 1:1 compile
        }
      }
    },
    coffee: {
      compile: {
        files: {
        'js/bingo.js': 'assets/js/bingo.coffee', // 1:1 compile
        }
      }
    },
    watch: {
      scripts: {
        files: ["assets/css/**/*.styl","assets/js/**/*.coffee"],
        tasks: ["stylus","coffee"],
        options: {
          nospawn: true
        }
      }
    }
  });
  grunt.loadNpmTasks("grunt-contrib-stylus");
  grunt.loadNpmTasks("grunt-contrib-watch");
  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.registerTask("default", ["stylus","coffee"]);
};
