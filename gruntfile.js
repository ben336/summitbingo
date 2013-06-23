
/*
# Grunt Config
This serves as the main configuration file for grunt.
It controls the different tasks.
Unfortunately, it also doesn"t get along well with dox our documentation
engine, because dox doesn"t handle comment like syntax in strings
very well, and chokes on it.
*/
var banner = '\n/*\n<%= pkg.name %> - v<%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %> \n' +
        'Created with Care by Ben McCormick\n'+
        'Feel free to check out the source or' +
        ' contribute at \nhttps://github.com/ben336/summitbingo\n*/\n';


module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    stylus: {
      compile: {
        options: {
          banner:banner,
          paths: ["assets/css/**/*.styl"],
        },
        files: {
          "css/bingo.css": "assets/css/bingo.styl" // 1:1 compile
        }
      }
    },
    uglify: {
      options: {
        mangle:false,
        banner: banner

      },
      my_target: {
        files: {
          'js/bingo.js': ['js/bingo.src.js']
        }
      }
    },
    coffee: {
      compile: {
        files: {
        'js/bingo.src.js': 'assets/js/bingo.coffee', // 1:1 compile
        }
      }
    },
    watch: {
      scripts: {
        files: ["assets/css/**/*.styl","assets/js/**/*.coffee"],
        tasks: ["stylus","coffee","uglify"],
        options: {
          nospawn: true
        }
      }
    }
  });
  grunt.loadNpmTasks("grunt-contrib-stylus");
  grunt.loadNpmTasks("grunt-contrib-watch");
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.registerTask("default", ["stylus","coffee","uglify"]);
};
