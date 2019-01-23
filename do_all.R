# https://github.com/rampatra/photography
# gulp
# bundle exec jekyll serve


setwd('images')
source('order_photos.R')
setwd('..')
system('gulp')
system('bundle exec jekyll build')
