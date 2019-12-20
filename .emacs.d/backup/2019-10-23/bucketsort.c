// OpenMP introductory example:  sampling bucket sort

// compile:  gcc -fopenmp -o bsort bucketsort.c

// set the number of threads via the environment variable
// OMP_NUM_THREADS, e.g. in the C shell

// setenv OMP_NUM_THREADS 8

#include <omp.h>  // required
#include <stdlib.h>

// needed for call to qsort()
int cmpints(int *u, int *v) 
{  if (*u < *v) return -1;
   if (*u > *v) return 1;
   return 0;
}

// adds xi to the part array, increments npart, the length of part
void grab(int xi, int *part, int *npart)
{
    part[*npart] = xi;
    *npart += 1;
}

// finds the min and max in y, length ny, 
// placing them in miny and maxy
void findminmax(int *y, int ny, int *miny, int *maxy)
{  int i,yi;
   *miny = *maxy = y[0];
   for (i = 1; i < ny; i++) {
      yi = y[i];
      if (yi < *miny) *miny = yi;
      else if (yi > *maxy) *maxy = yi;
   }
}

// sort the array x of length n
void bsort(int *x, int n)
{  // these are local to this function, but shared among the threads
   float *bdries; int *counts;
   #pragma omp parallel  
   // entering this block activates the threads, each executing it
   {  // variables declared below are local to each thread
      int me = omp_get_thread_num();
      // have to do the next call within the block, while the threads
      // are active
      int nth = omp_get_num_threads();
      int i,xi,minx,maxx,start;
      int *mypart;
      float increm;
      int SAMPLESIZE;
      // now determine the bucket boundaries; nth - 1 of them, by
      // sampling the array to get an idea of its range 
      #pragma omp single  // only 1 thread does this, implied barrier at end
      {
         if (n > 1000) SAMPLESIZE = 1000;
         else SAMPLESIZE = n / 2;
         findminmax(x,SAMPLESIZE,&minx,&maxx);
         bdries = malloc((nth-1)*sizeof(float));
         increm = (maxx - minx) / (float) nth;
         for (i = 0; i < nth-1; i++) 
            bdries[i] = minx + (i+1) * increm;
         // array to serve as the count of the numbers of elements of x
         // in each bucket
         counts = malloc(nth*sizeof(int));
      }
      // now have this thread grab its portion of the array; thread 0
      // takes everything below bdries[0], thread 1 everything between
      // bdries[0] and bdries[1], etc., with thread nth-1 taking
      // everything over bdries[nth-1]
      mypart = malloc(n*sizeof(int)); int nummypart = 0;
      for (i = 0; i < n; i++) {  
         if (me == 0) {
            if (x[i] <= bdries[0]) grab(x[i],mypart,&nummypart);
         }
         else if (me < nth-1) {
            if (x[i] > bdries[me-1] && x[i] <= bdries[me]) 
               grab(x[i],mypart,&nummypart);
         } else
            if (x[i] > bdries[me-1]) grab(x[i],mypart,&nummypart);
      }
      // now record how many this thread got
      counts[me] = nummypart;
      // sort my part
      qsort(mypart,nummypart,sizeof(int),cmpints);
      #pragma omp barrier  // other threads need to know all of counts
      // copy sorted chunk back to the original array; first find start point
      start = 0;
      for (i = 0; i < me; i++) start += counts[i];
      for (i = 0; i < nummypart; i++) {
         x[start+i] = mypart[i];
      }
   }
   // implied barrier here; main thread won't resume until all threads
   // are done
}

int main(int argc, char **argv)
{  
   // test case
   int n = atoi(argv[1]), *x = malloc(n*sizeof(int));
   int i;
   for (i = 0; i < n; i++) x[i] = rand() % 50;
   if (n < 100) 
      for (i = 0; i < n; i++) printf(%dn,x[i]);
   bsort(x,n);
   if (n <= 100) {
      printf(x after sorting:n);
      for (i = 0; i < n; i++) printf(%dn,x[i]);
   }
}

