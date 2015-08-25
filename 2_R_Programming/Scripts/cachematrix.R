## This function was created as part of the R Programming course offered by Coursera
## The functions are to cache values in order to reduce wait times is performing the 
## calculations.



##This function creates a list of functions, the purpose of which, is to cache the inverse
##matrix or to tell the function below to run the calculatation.


makeCacheMatrix <- function(x = numberic()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }

        get <- function() x
        setInverse <- function(Inverse) m <<- Inverse
        getInverse <- function() m
        list(set = set, get = get,
             setInverse = setInverse,
             getInverse = getInverse)
}


## This function first queries the function above for a cached value or will calculated the
## inverse.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m <- x$getInverse()				#query the X vector
        if(!is.null(m)) {				#if there is a cache
                message("getting cached data")	
                return(m)				#return the cache
        }
        data <- x$get()
        m <- solve(data, ...)  			#Actual computation here
        x$setInverse(m)					#Set value back to x cache
        m							#return the result
}
