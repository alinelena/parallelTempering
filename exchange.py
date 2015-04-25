#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function
import numpy as np
import sys
import math


def swapTemperatures(A):
  nrep=len(A[:,0])
  i=np.random.randint(0,nrep-1)
  B=np.copy(A)
  B.view('i8,i8,i8,i8').sort(axis=0,order=['f1'])
  Ti=B[i,1]
  for k in range(nrep-1):
    if B[k,1] == Ti:
      ind=k
  h=int(B[ind,0]-1)
  j=int(B[ind+1,0]-1)
  return (h,j)

def setRandomNumber(seed,n,m):

  np.random.seed(seed)
  for i in range(n):
    np.random.randint(0,m-1)
    np.random.rand()

kb=1.38065040000000E-23/4.35974393937059E-18

A=np.loadtxt(sys.argv[1])
seed=int(sys.argv[2])
nToSkip=int(sys.argv[3])
m=len(A[:,0])-1
setRandomNumber(seed,nToSkip,m)

(i,j)=swapTemperatures(A)

Ri=A[i,0]
Rj=A[j,0]
Ti=A[i,1]
Tj=A[j,1]
Vi=A[i,3]+A[i,2]
Vj=A[j,3]+A[j,2]
print("trying to exchage T ",Ti," and ",Tj )

delT=kb*(Ti-Tj)
delV=(Vi-Vj)
w=delV/delT
r=np.random.rand()
nToSkip=nToSkip+1
if r < math.exp(w) :
  print("swap ",Ri,Rj,Ti,Tj,nToSkip)
else:
  print("keep", Ri,Rj,Ti,Tj,nToSkip)
