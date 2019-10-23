#Institute of Physics - Federal University of Rio de Janeiro
#Interdisciplinary Academic Master's Degree in Applied Physics
#Student: Marcos Vieira
#October, 2019

# library( dplyr )
# library( readxl )
# library( writexl )

matrixfromtable <- function( filename, nodesnumber ){

  options( warn = -1 )

  storeoutputs          <- list()

  # Import and store data
  network               <- data.frame( read_excel( "table.xlsx" ) )
  nodes                 <- data.frame( network %>% select( nodeout, nodein, action ) )
  names( nodes )        <- c( "nodeout", "nodein", "action" )

  nnames                <- dplyr::union( nodes[[1]], nodes[[2]] )
  nnamessort            <- sort( nnames )

  message( "\nnodes list:" )
  message( nnamessort, "\n" )

  totalnodes            <- length( nnames )

  message( "Total number of nodes:" )
  message( totalnodes, "\n" )

  others                  <-  nodes %>% filter( action== "?" )
  # nodesaction            <-  nodes %>% filter( action== "action1" || action=="action2" ) %>% mutate( action=1 )
  nodesaction             <-  nodes %>% mutate( action=1 )

  # partial matrix
  partialmatrix            <- as.data.frame( table( nodesaction ) ) %>% select( nodeout, nodein, Freq )

  # getting the differences between each collum
  dif1                     <- c( setdiff( partialmatrix$nodein,partialmatrix$nodeout ) )
  dif2                     <- c( setdiff( partialmatrix$nodeout, partialmatrix$nodein ) )

  # filling each missing node of the collums with a combination with the others
  vdif1                    <- lapply( seq( 1,length( dif1 ) ), function( x ){ cbind( c( rep( dif1[x],totalnodes ) ), nnames[], as.integer( 0 ) ) } )
  vdif2                    <- lapply( seq( 1,length( dif2 ) ), function( x ){ cbind( nnames[], c( rep( dif2[x],totalnodes ) ), as.integer( 0 ) ) } )

  vdif1all                 <- as.data.frame( rbind( vdif1[[1]], vdif2[[1]] ) ) #here still 'manual'.
  names( vdif1all )        <- c( "nodeout", "nodein", "Freq" )

  # matching class of data.frame for binding
  vdif1all                 <- vdif1all %>% mutate( Freq = as.integer( Freq ) )
  vdif1all                 <- vdif1all %>% mutate( Freq = as.integer( 0*Freq ) )

  compactvation            <- bind_rows( partialmatrix,vdif1all )

  tabcompactvation         <- table( compactvation, deparse.level = 2 )

  # to get only the one with freq = 1
  dirmatrix                <- matrix( tabcompactvation, ncol=2*totalnodes )[, (totalnodes + 1):(2*totalnodes)]
  adjmatrix                <- ( (dirmatrix + t(dirmatrix)) > 0 )*1

  datadirmatrix            <- data.frame( dirmatrix, row.names = nnamessort )
  names( datadirmatrix )   <- nnamessort

  dataadjmatrix            <- data.frame( adjmatrix, row.names = nnamessort )
  names( dataadjmatrix )   <- nnamessort

  storeoutputs$dirmatrix   <- datadirmatrix
  storeoutputs$adjmatrix   <- dataadjmatrix
  storeoutputs$others      <- others
  storeoutputs$nnamessort  <- nnamessort

  write_xlsx( dataadjmatrix, "adjmatrix.xlsx" )
  write_xlsx( datadirmatrix, "dirmatrix.xlsx" )

  return(storeoutputs)
}

# outstore   <- matrixfromtable( "table.xlsx", 6  )

# outstore$dirmatrix
# outstore$adjmatrix
