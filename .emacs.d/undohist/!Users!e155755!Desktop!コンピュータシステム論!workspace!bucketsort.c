
((digest . "81254f03ce16c495d0622b486ccf7302") (undo-list nil (296 . 298) nil ("l" . -296) ((marker . 298) . -1) ("i" . -297) ((marker . 298) . -1) ("b" . -298) ((marker . 298) . -1) 299 nil (nil rear-nonsticky nil 301 . 302) (nil fontified nil 283 . 302) (283 . 302) nil (nil rear-nonsticky nil 281 . 282) (nil fontified nil 263 . 282) (263 . 282) nil ("#include <stdlib.h>" . 263) ((marker) . -19) nil (283 . 284) nil ("
" . 283) ((marker . 302) . -1) ((marker . 302) . -1) ((marker* . 302) . 1) nil (283 . 284) (t 23983 49670 698193 676000) nil ("d" . -2676) ((marker . 298) . -1) 2677 (t 23983 49627 774516 261000) nil (3655 . 3656) nil (nil rear-nonsticky nil 3654 . 3655) (nil fontified nil 3649 . 3655) (nil fontified nil 3641 . 3649) (nil fontified nil 3635 . 3641) (nil fontified nil 3622 . 3635) (nil fontified nil 3595 . 3622) (nil fontified nil 3575 . 3595) (nil fontified nil 3520 . 3575) (nil fontified nil 3514 . 3520) (nil fontified nil 3476 . 3514) (nil fontified nil 3475 . 3476) (nil fontified nil 3460 . 3475) (nil fontified nil 3454 . 3460) (nil fontified nil 3332 . 3454) (nil fontified nil 3330 . 3332) (nil fontified nil 3329 . 3330) (nil fontified nil 3195 . 3329) (nil fontified nil 3182 . 3195) (nil fontified nil 3122 . 3182) (nil fontified nil 3121 . 3122) (nil fontified nil 2737 . 3121) (nil fontified nil 2736 . 2737) (nil fontified nil 2682 . 2736) (nil fontified nil 2665 . 2682) (nil fontified nil 2653 . 2665) (nil fontified nil 2652 . 2653) (nil fontified nil 2620 . 2652) (nil fontified nil 2619 . 2620) (nil fontified nil 2618 . 2619) (nil fontified nil 2598 . 2618) (nil fontified nil 2597 . 2598) (nil fontified nil 2596 . 2597) (nil fontified nil 2584 . 2596) (nil fontified nil 2505 . 2584) (nil fontified nil 2504 . 2505) (nil fontified nil 2427 . 2504) (nil fontified nil 2425 . 2427) (nil fontified nil 2084 . 2425) (nil fontified nil 2053 . 2084) (nil fontified nil 1894 . 2053) (nil fontified nil 1893 . 1894) (nil fontified nil 1754 . 1893) (nil fontified nil 1753 . 1754) (nil fontified nil 1748 . 1753) (nil fontified nil 1747 . 1748) (nil fontified nil 1553 . 1747) (nil fontified nil 1552 . 1553) (nil fontified nil 1551 . 1552) (nil fontified nil 1545 . 1551) (nil fontified nil 1045 . 1545) (nil fontified nil 1044 . 1045) (nil fontified nil 1042 . 1044) (nil fontified nil 1020 . 1042) (nil fontified nil 1019 . 1020) (nil fontified nil 607 . 1019) (nil fontified nil 606 . 607) (nil fontified nil 520 . 606) (nil fontified nil 501 . 520) (nil fontified nil 342 . 501) (nil fontified nil 341 . 342) (nil fontified nil 1 . 341) (1 . 3655) nil ("
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
         } delse
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
      for (i = 0; i < n; i++) printf(\"%d\\n\",x[i]);
   bsort(x,n);
   if (n <= 100) {
      printf(\"x after sorting:\\n\");
      for (i = 0; i < n; i++) printf(\"%d\\n\",x[i]);
   }
}// OpenMP introductory example:  sampling bucket sort

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

" . 1) ((marker . 1) . -7301) ((marker . 283) . -7301) ((marker . 1) . -283) ((marker . 1) . -283) ((marker . 2695) . -283) ((marker . 283) . -7301) ((marker . 284) . -7301) ((marker . 263) . -283) ((marker . 264) . -284) ((marker . 2684) . -7301) ((marker . 2685) . -7301) ((marker . 3674) . -3708) ((marker . 3674) . -3709) ((marker) . -7301) (t 23983 49522 556608 399000) nil ("
" . 284) ((marker . 283) . -1) ((marker . 1) . -1) ((marker . 2695) . -1) ((marker . 283) . -1) nil ("#include \"PrimeThreads.h\"" . 284) nil ("
" . 284) ((marker . 263) . -1) nil ("#include <stdio.h>" . 284) (t 23983 47162 325178 158000) nil (328 . 329) nil (nil rear-nonsticky nil 327 . 328) (nil fontified nil 312 . 328) (nil fontified nil 303 . 312) (303 . 328) nil (303 . 304) (t 23983 47114 772349 999000) nil (299 . 301) nil (294 . 299) nil (287 . 295) nil ("d" . -287) ((marker . 298) . -1) 288 nil (284 . 288) nil ("i" . -1) ((marker . 298) . -1) ((marker . 2685) . -1) ("n" . -2) ((marker . 298) . -1) ("c" . -3) ((marker . 298) . -1) ("l" . -4) ((marker . 298) . -1) ("u" . -5) ((marker . 298) . -1) 6 nil ("n" . -6) ((marker . 298) . -1) ("e" . -7) ((marker . 298) . -1) 8 nil (1 . 8) nil (1 . 2) (t 23983 47022 738899 355000) nil (nil rear-nonsticky nil 3654 . 3655) (nil fontified nil 3649 . 3655) (nil fontified nil 3641 . 3649) (nil fontified nil 3635 . 3641) (nil fontified nil 3622 . 3635) (nil fontified nil 3595 . 3622) (nil fontified nil 3575 . 3595) (nil fontified nil 3520 . 3575) (nil fontified nil 3514 . 3520) (nil fontified nil 3476 . 3514) (nil fontified nil 3475 . 3476) (nil fontified nil 3460 . 3475) (nil fontified nil 3454 . 3460) (nil fontified nil 3332 . 3454) (nil fontified nil 3330 . 3332) (nil fontified nil 3195 . 3330) (nil fontified nil 3182 . 3195) (nil fontified nil 3122 . 3182) (nil fontified nil 3121 . 3122) (nil fontified nil 2737 . 3121) (nil fontified nil 2736 . 2737) (nil fontified nil 2682 . 2736) (nil fontified nil 2665 . 2682) (nil fontified nil 2653 . 2665) (nil fontified nil 2652 . 2653) (nil fontified nil 2620 . 2652) (nil fontified nil 2619 . 2620) (nil fontified nil 2618 . 2619) (nil fontified nil 2598 . 2618) (nil fontified nil 2597 . 2598) (nil fontified nil 2596 . 2597) (nil fontified nil 2584 . 2596) (nil fontified nil 2505 . 2584) (nil fontified nil 2504 . 2505) (nil fontified nil 2427 . 2504) (nil fontified nil 2425 . 2427) (nil fontified nil 2084 . 2425) (nil fontified nil 2053 . 2084) (nil fontified nil 1894 . 2053) (nil fontified nil 1893 . 1894) (nil fontified nil 1754 . 1893) (nil fontified nil 1753 . 1754) (nil fontified nil 1748 . 1753) (nil fontified nil 1747 . 1748) (nil fontified nil 1553 . 1747) (nil fontified nil 1552 . 1553) (nil fontified nil 1551 . 1552) (nil fontified nil 1545 . 1551) (nil fontified nil 1045 . 1545) (nil fontified nil 1044 . 1045) (nil fontified nil 1042 . 1044) (nil fontified nil 1020 . 1042) (nil fontified nil 607 . 1020) (nil fontified nil 606 . 607) (nil fontified nil 520 . 606) (nil fontified nil 501 . 520) (nil fontified nil 342 . 501) (nil fontified nil 341 . 342) (nil fontified nil 1 . 341) (1 . 3655) (t 23983 46205 330100 362000)))
