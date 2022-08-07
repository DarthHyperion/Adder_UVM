#include <stdio.h>
#include <iostream>
#include <svdpi.h>

using namespace std;

extern "C" int sum_func(int a, int b){
  
  return (a+b);
 
}