#!/bin/bash

SAMPLE_SIZE=100
MODELS=$(ollama list | grep -v NAME | sort | cut -f1 -d ' ' | sort -t : -k2 -r --human-numeric-sort)

EVALS_ARG="--evaluations boolq winogrande hellaswag rte piqa commonsenseqa multirc arc cb"

for MODEL in $MODELS; do
    MODEL_ARG="--model $MODEL"

    SAMPLE_SIZE_ARG="--sample-size $SAMPLE_SIZE"
    if [ $SAMPLE_SIZE -eq 0 ]; then
        SAMPLE_SIZE_ARG=""
    fi
    echo "Running evaluations for model: $MODEL"
    
    python main.py $MODEL_ARG $SAMPLE_SIZE_ARG $EVALS_ARG > results/${MODEL}-eval-results.log

    echo "Completed evaluations for model: $MODEL"
done
