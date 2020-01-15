#!/bin/bash
echo  123 > a1
ln -s a1 a2
echo 321 > a2
ln a2 a3
echo  456 >> a3
rm a1
echo abc >> a1
cat a1 a2 a3



