#rm *.o
echo "compilando $1.c..."

# -xvpara: display compiler parallelization messages
cc -xopenmp -xO3 -xvpara $1.c -o $1
