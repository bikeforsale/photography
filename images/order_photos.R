add_zero <- function(x, n){
  x <- as.character(x)
  adders <- n - nchar(x)
  adders <- ifelse(adders < 0, 0, adders)
  for (i in 1:length(x)){
    if(!is.na(x[i])){
      x[i] <- paste0(
        paste0(rep('0', adders[i]), collapse = ''),
        x[i],
        collapse = '')  
    } 
  }
  return(x)
}

fotos <- dir()
fotos <- fotos[grepl('jpg', tolower(fotos))]
new_names <- gsub('.jpg', '.JPG', fotos, fixed = TRUE)
for(i in 1:length(fotos)){
  old_name <- fotos[i]
  new_name <- new_names[i]
  if(old_name != new_name){
    file.rename(from = old_name, to = new_name)
  }
}

# Reorder and rename by date
system("for i in *.JPG; do   dst=$(exif -t 0x9003 -m $i ) &&   dst_esc=$(echo $dst | sed 's/ /-/g' ) &&  mv $i $dst_esc.JPG; done;")

# Reverse
fotos <- dir()
fotos <- fotos[grepl('jpg', tolower(fotos))]
# fotos <- rev(fotos)
until <- as.POSIXct('2030-01-01 23:59:59')
for(i in 1:length(fotos)){
  old_foto <- fotos[i]
  old_date <- gsub('.JPG', '', old_foto, fixed = TRUE)
  old_date <- paste0(
    substr(old_date, 1, 4),
    '-',
    substr(old_date, 6, 7),
    '-',
    substr(old_date, 9, 10),
    ' ',
    substr(old_date, 12, 20)
  )
  old_date <- as.POSIXct(old_date)
  gap <- until - old_date
  gap <- as.numeric(gap)
  gap <- round(gap, digits = 1)
  gap <- gap * 10
  gap <- add_zero(gap, 10)
  file.rename(from = fotos[i],
              to = paste0(gap, '.JPG'))
}