#!/bin/bash

argv () {
  if test ! -f ./${BASH_ARGV[$#-1]}.exe
  then   
    # compilar
    local compilar="ocamlopt -o"
    for (( i=$#-1; i > -1; i-- )) 
    do
      compilar+=" ${BASH_ARGV[i]}"
    done
    $compilar

    # remover arquivos desnecessarios
    if [[ "${BASH_ARGV[$#-1]}" == *"/"* ]]
    then 
      rm -vf ${BASH_ARGV[$#-1]%/*}/*.o ${BASH_ARGV[$#-1]%/*}/*.cm* 
    else
      rm -vf *\.o  *\.cm*
    fi 
  fi 

  # executar
  "./${BASH_ARGV[$#-1]}.exe"

}

argv "$@"
