#!/bin/bash

# create.sh は 解答環境を作成します。
# 作業ファイル群を作成します。
# @param {string} SELECT_LANG - 利用言語 python | php
# @param {int} TEST_NUM - 作成するテストファイル数
# @param {string} WORK_NAME - 作業名
# @return {int} - 正常終了なら0, そうでないなら1を返します。
function main() {
  makeWorkDirectories $1 $2 $3
}

# 定数宣言
DEFAULT_WORK_NAME="procon"
DEFAULT_INPUT_DIR="stdin"
DEFAULT_EXPECT_DIR="expect"
ENABLE_LANGUAGES="python:py php:php" #langName:langExt の形式

# 作業名を正規化します。
# WORK_NAMEが無効な値ならDEFAULT_WORK_NAMEを使います。
# 同一の名前が作業ディレクトリがあるならsuffixを付けます。
# @param {string} WORK_NAME - 作業名
# @return {string} - 正規化した作業名を返します。
function normalizeWorkName() {
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

# LANG_NAME をその拡張子に変換します
# @param {python|php} LANG_NAME - 利用言語名 
# @return {py|php} - スクリプト拡張子
function langName2LangExt() {
  lang_name=$1
  is_find=false
  for enable_lang in $ENABLE_LANGUAGES
  do
    enable_lang_name=`echo $enable_lang | cut -f 1 -d ":"`
    enable_lang_ext=`echo $enable_lang | cut -f 2 -d ":"`
    if [ $lang_name = $enable_lang_name ]; then
      echo $enable_lang_ext
      is_find=true
    fi
  done
  if [ "$is_find" = "false" ]; then
    exit 1
  fi
}

# 作業ファイル群を作成します。
# @param {string} SELECT_LANG - 利用言語 python | php
# @param {int} TEST_NUM - 作成するテストファイル数
# @param {string} WORK_NAME - 作業名
function makeWorkDirectories() {
  select_lang_name=$1
  select_lang_ext=`langName2LangExt $select_lang_name`
  test_num=$2
  work_name=`normalizeWorkName $3`

  mkdir -p $work_name
  cd $work_name
  touch "${work_name}.${select_lang_ext}"

  mkdir -p $DEFAULT_INPUT_DIR
  mkdir -p $DEFAULT_EXPECT_DIR
  for i in `seq 1 $test_num`;
  do
    touch "${DEFAULT_INPUT_DIR}/${i}.in"
    touch "${DEFAULT_EXPECT_DIR}/${i}.out"
  done
  echo "${work_name}を${select_lang_name}でセットアップしました。"
  return 0
}

# 実行
main $1 $2 $3
