# exports each essay to a txt file





#must take a dataframe with the first column being the id and the second column being the esssay
text_file_prep <- function(essays_and_ids, wd){
    setwd(wd)
    remove_at <- function(essay){
        str_replace(string=essay, pattern="@", replacement="")
    }
    index <- 95
    essays_and_ids$essay <- sapply(essays_and_ids[,2], remove_at)
    write_to_txt <- function(index){
        fileConn<-file(paste(essays_and_ids[index,1],".txt", sep=""))
        writeLines(essays_and_ids[index,2], fileConn)
        close(fileConn)
    }
    len <- length(essays_and_ids$id)
    sapply(1:len,write_to_txt)
    
}
#testing the above function
#essays_and_ids <- test[1:10,c(1,3)]
#rm(essays_and_ids)
#text_file_prep(essays_and_ids)


#I know this is less efficient to do in a loop buI was not able to get the file names wo
text_file_prep_loop <- function(essays_and_ids, wd){
    setwd(wd)
    remove_at <- function(essay){
        str_replace(string=essay, pattern="@", replacement="")
    }
    essays_and_ids$essay <- sapply(essays_and_ids[,2], remove_at)
    for (essay in 1:length(essays_and_ids$essay)){
        index <- essay + min(as.numeric(as.character(essays_and_ids$id)))
        fileConn <- file(paste(essays_and_ids[index,1],".txt", sep=""))
        writeLines(essays_and_ids[index,2], fileConn)
        close(fileConn)  
    }
    
}


