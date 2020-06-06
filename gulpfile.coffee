'use strict'

gulp = require('gulp')
watch = require('gulp-watch')
autoprefixer = require('gulp-autoprefixer')
sass = require('gulp-sass')
cleanCSS = require('gulp-clean-css')
rename = require("gulp-rename")
rigger = require('gulp-rigger')
slim = require('gulp-slim')
browserSync = require('browser-sync')
header = require('gulp-header')
reload = browserSync.reload

path =
  dist: 'dist/'
  build:
    html:   'build/'
    js:     'build/js/'
    css:    'build/css/'
    img:    'build/img/'
    fonts:  'build/fonts/'
  src:
    vetbox:
      core:  'src/styles/vetbox.sass'
      media:  'src/styles/media.sass'
    slim:   'src/*.slim'
    js:     'src/js/main.js'
    style:  'src/styles/demo.sass'
    img:    'src/img/**/*.*'
    fonts:  'src/fonts/**/*.*'
  watch:
    slim:   'src/*.slim'
    js:     'src/js/**/*.js'
    style:  'src/styles/**/**/*.sass'
    img:    'src/img/**/*.*'
    fonts:  'src/fonts/**/*.*'

config =
  server: baseDir: './build'
  tunnel: true
  host: 'localhost'
  port: 3333
  logPrefix: 'Gulp_log'
  
swallowError = (error)->
  console.log error.toString()
  this.emit('end')

gulp.task 'html:build', ->
  gulp.src(path.src.slim)
    .pipe(rigger())
    .pipe(slim(pretty: true))
    .on('error', swallowError)
    .pipe(gulp.dest(path.build.html))
    .pipe reload(stream: true)

gulp.task 'style:build', ->
  gulp.src(path.src.style)
    .pipe(sass())
    .on('error', swallowError)
    .pipe(gulp.dest(path.build.css))
    .pipe reload(stream: true)

gulp.task 'js:build', ->
  gulp.src(path.src.js)
    .pipe(rigger())
    .on('error', swallowError)
    .pipe(gulp.dest(path.build.js))
    .pipe reload(stream: true)

gulp.task 'image:build', ->
  gulp.src(path.src.img)
    .on('error', swallowError)
    .pipe(gulp.dest(path.build.img))
    .pipe reload(stream: true)

gulp.task 'build', [
  'html:build'
  'style:build'
]

gulp.task 'watch', ->
  watch [ path.watch.slim ], (event, cb) ->
    gulp.start 'html:build'
  watch [ path.watch.style ], (event, cb) ->
    gulp.start 'style:build'

gulp.task 'webserver', ->
  browserSync config

gulp.task 'default', [
  'build'
  'webserver'
  'watch'
]

pkg = require './package.json'
fs = require 'fs'
sassConfig = fs.readFileSync('./src/styles/config.sass', 'utf-8').replace(/\n$/, '')
mediaConfig = fs.readFileSync('./src/styles/media.sass', 'utf-8').replace(/\n$/, '').replace('@import "vetbox"\n\n', '')

banner = """
/*
@version v<%= pkg.version %>

#{sassConfig}
*/\n\n
"""

mediaBanner = """
#{banner}
/*
#{mediaConfig}
*/\n\n\n
"""


gulp.task 'dist', ->
  gulp.src(path.src.vetbox.core)
    .pipe(sass())
    .pipe(autoprefixer())
    .pipe(header(banner, { pkg : pkg } ))
    .pipe(gulp.dest(path.dist))
    .pipe(cleanCSS())
    .pipe(header(banner, { pkg : pkg } ))
    .pipe(rename(suffix: ".min"))
    .pipe(gulp.dest(path.dist))
    
  gulp.src(path.src.vetbox.media)
    .pipe(rename(basename: "vetbox.media"))
    .pipe(sass())
    .pipe(autoprefixer())
    .pipe(header(mediaBanner, { pkg : pkg } ))
    .pipe(gulp.dest(path.dist))
    .pipe(cleanCSS())
    .pipe(header(mediaBanner, { pkg : pkg } ))
    .pipe(rename(suffix: ".min"))
    .pipe(gulp.dest(path.dist))
