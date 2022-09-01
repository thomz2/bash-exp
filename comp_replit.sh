#!/bin/bash

shopt -s extdebug

argv () {
  
  # adicionar OR testando se o arquivo atual é diferente do oculto

  for (( i=$#-2; i > -1; i-- ))
  do 
    if ! cmp -s ${BASH_ARGV[i]} ".${BASH_ARGV[i]}" || test ! -f ./${BASH_ARGV[$#-1]}
    then 
      # se achou algum diferente ou nao existe arquivo compilado, compilo
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
      break
    fi
  done

  # executar
  "./${BASH_ARGV[$#-1]}"

  # criar arquivo(s) oculto(s) contendo codigo 
  for (( i=$#-2; i > -1; i-- )) # pegando apenas arquivos .ml
  do
    cp ${BASH_ARGV[i]} ".${BASH_ARGV[i]}" 
  done
}

argv "$@"
