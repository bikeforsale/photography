# https://github.com/rampatra/photography
# gulp
# bundle exec jekyll serve


setwd('images')
# source('../order_photos.R', chdir = FALSE)
fulls <- dir('fulls')
thumbs <- dir('thumbs')
removes <- thumbs[!thumbs %in% fulls]
for(i in 1:length(removes)){
  file.remove(paste0('thumbs/', removes[i]))
}
