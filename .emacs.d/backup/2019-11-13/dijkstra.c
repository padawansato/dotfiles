// Dijkstra.c
// OpenMP example program: Dijkstra shortest-path finder in a
// bidirectional graph; finds the shortest path from vertex 0 to all
// others
// usage: dijkstra nv print
// where nv is the size of the graph, and print is 1 if graph and min
10 // distances are to be printed out, 0 otherwise
11
12 #include <omp.h>
13
14 // global variables, shared by all threads by default; could placed them
15 // above the "parallel" pragma in dowork()
16
17 int nv, // number of vertices
18 *notdone, // vertices not checked yet
19 nth, // number of threads
20 chunk, // number of vertices handled by each thread
21 md, // current min over all threads
22 mv, // vertex which achieves that min
23 largeint = -1; // max possible unsigned int
24
25 unsigned *ohd, // 1-hop distances between vertices; "ohd[i][j]" is
26 // ohd[i*nv+j]
27 *mind; // min distances found so far
28
29 void init(int ac, char **av)
30 { int i,j,tmp;
31 nv = atoi(av[1]);
32 ohd = malloc(nv*nv*sizeof(int));
33 mind = malloc(nv*sizeof(int));
34 notdone = malloc(nv*sizeof(int));
35 // random graph
36 for (i = 0; i < nv; i++)
37 for (j = i; j < nv; j++) {
38 if (j == i) ohd[i*nv+i] = 0;
39 else {
40 ohd[nv*i+j] = rand() % 20;
41 ohd[nv*j+i] = ohd[nv*i+j];
42 }
43 }
44 for (i = 1; i < nv; i++) {
45 notdone[i] = 1;
46 mind[i] = ohd[i];
47 }
48 }
49
50 // finds closest to 0 among notdone, among s through e
51 void findmymin(int s, int e, unsigned *d, int *v)
52 { int i;
53 *d = largeint;
54 for (i = s; i <= e; i++)
55 if (notdone[i] && mind[i] < *d) {
56 *d = mind[i];
57 *v = i;
58 }
59 }
60
61 // for each i in [s,e], ask whether a shorter path to i exists, through
4.2. EXAMPLE: DIJKSTRA SHORTEST-PATH ALGORITHM 83
62 // mv
63 void updatemind(int s, int e)
64 { int i;
65 for (i = s; i <= e; i++)
66 if (mind[mv] + ohd[mv*nv+i] < mind[i])
67 mind[i] = mind[mv] + ohd[mv*nv+i];
68 }
69
70 void dowork()
71 {
72 #pragma omp parallel
73 { int startv,endv, // start, end vertices for my thread
74 step, // whole procedure goes nv steps
75 mymv, // vertex which attains the min value in my chunk
76 me = omp_get_thread_num();
77 unsigned mymd; // min value found by this thread
78 #pragma omp single
79 { nth = omp_get_num_threads(); // must call from inside parallel block
80 if (nv % nth != 0) {
81 printf("nv must be divisible by nth\n");
82 exit(1);
83 }
84 chunk = nv/nth;
85 printf("there are %d threads\n",nth);
86 }
87 startv = me * chunk;
88 endv = startv + chunk - 1;
89 for (step = 0; step < nv; step++) {
90 // find closest vertex to 0 among notdone; each thread finds
91 // closest in its group, then we find overall closest
92 #pragma omp single
93 { md = largeint; mv = 0; }
94 findmymin(startv,endv,&mymd,&mymv);
95 // update overall min if mine is smaller
96 #pragma omp critical
97 { if (mymd < md)
98 { md = mymd; mv = mymv; }
99 }
#pragma omp barrier
// mark new vertex as done
#pragma omp single
{ notdone[mv] = 0; }
// now update my section of mind
updatemind(startv,endv);
#pragma omp barrier
}
}
}
int main(int argc, char **argv)
{ int i,j,print;
double startime,endtime;
init(argc,argv);
startime = omp_get_wtime();
// parallel
dowork();
// back to single thread
endtime = omp_get_wtime();
printf("elapsed time: %f\n",endtime-startime);
print = atoi(argv[2]);
if (print) {
printf("graph weights:\n");
for (i = 0; i < nv; i++) {
for (j = 0; j < nv; j++)
printf("%u ",ohd[nv*i+j]);
printf("\n");
}
printf("minimum distances:\n");
for (i = 1; i < nv; i++)
printf("%u\n",mind[i]);
}
}
