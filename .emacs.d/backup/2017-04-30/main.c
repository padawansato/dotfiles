#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#define MAXLEN 1000

int readlines(char *lineptr[], int maxlines)
{
    int len, nlines;
    char *p, line[MAXLEN];
    nlines = 0;
    while ((len = getline(line, MAXLEN)) > 0)
        if (nlines >= maxlines || (p = malloc(len)) == NULL)
            return -1; // 行が多過ぎたか，領域の確保に失敗した
        else {
            line[len - 1] = '\0';
            strcpy(p, line); // 読み込んだ文字列を確保した領域にコピーする
            lineptr[nlines++] = p;  // 文字列のアドレスを配列に登録する
        }
    return nlines;
}