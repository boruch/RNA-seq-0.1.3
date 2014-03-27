#!/bin/bash
for i in `myjobs | grep Eqw | awk '{print $1}'`;do qmod -c $i;done
#myjobs | grep r | awk '{print $5}'| wc -l
