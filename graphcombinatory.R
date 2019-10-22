#Institute of Physics - Federal University of Rio de Janeiro
#Interdisciplinary Academic Master's Degree in Applied Physics
#Student: Marcos Vieira
#October, 2019

library( dplyr )
library( readxl )
library( writexl )

graphcombinatory <- function( filename, nodesnumber ){

    source("matrixfromtable.R")

    #export directory
    if( dir.exists( "combinations" ) == FALSE ){ dir.create( "combinations" ) }

    storecombs      <- list()

    outstore   <- matrixfromtable( filename, nodesnumber )
    dirmatrix  <- outstore$dirmatrix
    others     <- outstore$others
    nnamessort <- outstore$nnamessort

    numberofunknows <- nrow( others )
    possiblecombs   <- 2^numberofunknows
    combvalues      <- distinct( as.data.frame( t( combn( rep( c( 0,1 ), possiblecombs ), numberofunknows ) ) ) )*-1 #use this to apply the changes

    storecombs$combvalues <- combvalues

    for( v in seq( 1:possiblecombs ) )
    {
        dirmatrixnew <- dirmatrix
        for( nother in seq(1:ncol(others)) )
        {
            dirmatrixnew[others[nother, -3][[2]]]   <- dirmatrix[others[nother, -3][[2]]] +
                                                as.integer( nnamessort==others[nother, -3][[1]] )*(combvalues[v,nother])
        }

        adjmatrixnew <- ( ( dirmatrixnew + t(dirmatrixnew) ) > 0 )*1

        storecombs$dircombination[[v]] <- dirmatrixnew
        storecombs$adjcombination[[v]] <- adjmatrixnew

        dirname <- paste( "combinations/dir_matrix_", toString( v ),".xlsx", sep="" )
        write_xlsx( dirmatrixnew, dirname )

        adjname <- paste( "combinations/adj_matrix_", toString( v ),".xlsx", sep="" )
        write_xlsx( dirmatrixnew, adjname )
    }
    return(storecombs)
}

output <- graphcombinatory( "table.xlsx", 6 )

output$dircombination
output$adjcombination