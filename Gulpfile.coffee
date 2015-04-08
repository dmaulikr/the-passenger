gulp = require 'gulp'
concat = require 'gulp-concat'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
plumber = require 'gulp-plumber'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
nib = require 'nib'
stylus = require 'gulp-stylus'
browserify = require 'gulp-browserify'

gulp.task 'stylus', ->
	gulp.src('www/css/src/styles.styl')
		.pipe plumber()
		.pipe stylus({use : [nib()], errors : true})
		.pipe gulp.dest('www/css/lib/')
  
gulp.task 'coffee', ->
	gulp.src('www/js/src/app.coffee')
		.pipe plumber()
		.pipe(coffee(bare: true).on('error', gutil.log))
		.pipe browserify({ transform: ['coffeeify'], extensions: ['.coffee'] })
		.pipe rename 'scripts.js'
		.pipe gulp.dest('www/js/lib/')

gulp.task 'watch', ->
  gulp.watch "www/js/src/**/*.coffee", [ 'coffee' ]
  gulp.watch "www/css/src/**/*.styl", [ 'stylus' ]

gulp.task 'default', [
  'coffee'
  'stylus'
  'watch'
]