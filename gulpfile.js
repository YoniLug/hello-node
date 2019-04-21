var gulp = require('gulp');

var clean = require('gulp-clean');
var jshint = require('gulp-jshint');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var path = require('path');

var bases = {
 app: 'app/',
 dist: 'dist/',
};

var paths = {
 scripts: ['app/*.js'],
 dist: path.join(__dirname, 'dist/')
};

// Delete the dist directory
gulp.task('clean', function() {
 return gulp.src(paths.dist)
 .pipe(clean());
});

// Process scripts and concatenate them into one output file
gulp.task('scripts', ['clean'], function() {
 gulp.src(paths.scripts)
 .pipe(jshint())
 .pipe(jshint.reporter('default'))
 .pipe(uglify())
 .pipe(concat('app.min.js'))
 .pipe(gulp.dest(paths.dist+'/app'));
});

// Copy all other files to dist directly
gulp.task('copy', ['clean'], function() {
 // Copy lib scripts, maintaining the original directory structure
 gulp.src(paths.scripts, {cwd: 'app/**'})
 .pipe(gulp.dest(paths.dist+'/app'));
});

gulp.task("copyMetaFiles", ["clean"], function () {
	return gulp.src(["package.json", "README.md"]).pipe(gulp.dest(paths.dist));
});
// Define the default task as a sequence of the above tasks
gulp.task('default', ['clean', 'copy','copyMetaFiles','scripts']);
gulp.task('build', ['default']);
