// grab our gulp packages
var gulp  = require('gulp'),
    shell = require('gulp-shell'),
    gutil = require('gulp-util');

// we define some constants here so they can be reused
var SRC_APP_HOME = 'C:/dev_workspace/gates_fresh/source/gates';
var DEPLOY_HOME = 'C:/softwares/jboss-eap-5.2/apps/GATES/deploy/gates.war';

/// java path
var SRC_JAVA_HOME = 'C:/dev_workspace/gates_fresh/source/gates/**/*.java';
/// jsp path
var SRC_JSP_PATH = SRC_APP_HOME+ "/gates-interactive-web/src/main/webapp/WEB-INF/jsp/**/*.jsp";
var TARGET_JSP_PATH = DEPLOY_HOME + "/WEB-INF/jsp";

// js path
var SRC_JS_PATH = SRC_APP_HOME+ "/gates-interactive-web/src/main/webapp/resources/**/*.js";
var TARGET_JS_PATH = DEPLOY_HOME + "/resources";

// cas jsp path
var SRC_CAS_PATH = SRC_APP_HOME+ "/gates-interactive-web/src/main/webapp/cas/*.jsp";
var TARGET_CAS_PATH = DEPLOY_HOME + "/cas";

/* File: gulpfile.js */



// create a default task and just log a message
gulp.task('default', function() {
  return gutil.log('Gulp is running!')
});

gulp.task('istatic', function() {
  //gulp.src("Test/*.txt").pipe(gulp.dest("Test1"));
  gulp.src(SRC_JSP_PATH).pipe(gulp.dest(TARGET_JSP_PATH));
  gulp.src(SRC_JS_PATH).pipe(gulp.dest(TARGET_JS_PATH));
  gulp.src(SRC_CAS_PATH).pipe(gulp.dest(TARGET_CAS_PATH));
  //return gutil.log('Gulp is running!')
});

gulp.task('watch', function() {
  var watcher = gulp.watch([SRC_JSP_PATH,SRC_JS_PATH,SRC_CAS_PATH],['istatic']);
  watcher.on('change', function(event) {
    gutil.log('File ' + event.path + ' was ' + event.type);
  });
});

/// i don't know this is not the right functionality need here
gulp.task('watchjava', function() {
   var watcher = gulp.watch([SRC_JAVA_HOME],['testcmd']);
   watcher.on('change', function(event) {
     console.log('File ' + event.path + ' was ' + event.type);
   });

  //gulp.src();
});
gulp.task('testcmd', shell.task(['echo testcmd']));
