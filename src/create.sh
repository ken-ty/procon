#!/bin/bash

DEFAULT_WORK_NAME="procon"

# 作業名を正規化します。
# WORK_NAMEが無効な値ならDEFAULT_WORK_NAMEを使います。
# 同一の名前が作業ディレクトリがあるならsuffixを付けます。
# @param {string} WORK_NAME - 作業名
# @return {string} - 正規化した作業名を返します。
function useWorkName() {
  work_name=$1
  # デフォルト作業名を使うかどうか
  if [ -z "$work_name" ]; then
    work_name="$DEFAULT_WORK_NAME"
  fi
  # suffixを付けるかどうか
  sameNameCount=`ls -l | grep $work_name | wc -l`
  if [ $sameNameCount -gt 0 ]; then
    work_name="${work_name}_`expr $sameNameCount + 1`"
  fi
  echo "$work_name"
}

# makeWorkDirectories 作業ファイル群を作成する TODO: py以外にも対応する
function makeWorkDirectories {
  USE_WORK_NAME=`useWorkName $1`
  mkdir -p ${USE_WORK_NAME}
  cd $USE_WORK_NAME
  touch ${USE_WORK_NAME}.py
  mkdir -p stdin
  touch stdin/1.in
  touch stdin/2.in
  touch stdin/3.in
  mkdir -p expect
  touch expect/1.out
  touch expect/2.out
  touch expect/3.out
  return 0
}

################################################################################

# create.sh は 解答環境を作成します。
makeWorkDirectories $1
