#!/bin/bash
#
################################################################################
# create.sh は 解答環境を作成します。
#
# Usage: ./create.sh -f work_name
# Usage: ./create.sh [option]
#
# Options:
#   -f 指定した作業名の解答環境を作成
#   -h ヘルプを表示
#   -v バージョンを表示
################################################################################
# Version:
#   0.0.1 初期バージョン作成
################################################################################


# usage() 使い方を表示する
function usage() {
  # usageはヘッダコメントから取得する.
  pattern='NR >= 4'
  action='{if (/^#/) { if (/^##########/) { exit } else {sub("^# ?", ""); print }} else { exit }}'
  awk "$pattern $action" $0
  return 0
}

# version() バージョンを表示する
function version() {
  pattern=''
  action='{if (/^# Version:/) { getline; sub("^#   ?", ""); print } }'
  awk "$pattern $action" $0
  return 0
}

# use_work_name() 作業名を決める
DEFAULT_WORK_NAME="procon_1" # nをカウントアップする.
USE_WORK_NAME=${DEFAULT_WORK_NAME}
function use_work_name() {
  if [ -z "$1" ]; then
    return 0 # 空ならDEFAULT_WORK_NAMEが反映される (エラーじゃない)
  fi
  USE_WORK_NAME=$1
  return 0
}

# make_work_directories 作業ファイル群を作成する TODO: py以外にも対応する
function make_work_directories {
  use_work_name $1
  mkdir ${USE_WORK_NAME}
  touch ${USE_WORK_NAME}/${USE_WORK_NAME}.py
  mkdir ${USE_WORK_NAME}/test
  touch ${USE_WORK_NAME}/${USE_WORK_NAME}.py
  touch ${USE_WORK_NAME}/test/1.in
  touch ${USE_WORK_NAME}/test/1.out
  touch ${USE_WORK_NAME}/test/2.in
  touch ${USE_WORK_NAME}/test/2.out
  touch ${USE_WORK_NAME}/test/3.in
  touch ${USE_WORK_NAME}/test/3.out
  return 0
}

readonly ALLOW_OPTIONS=":cf:hu:v" # 先頭の:でOPTARGを任意にした
while getopts $ALLOW_OPTIONS option; do
  case $option in
    :  ) make_work_directories         ;; # 解答環境を作成
    f  ) make_work_directories $OPTARG ;; # 引数で指定した名前の解答環境を作成
    v  ) version                       ;; # バージョンを出力
    h  ) usage                         ;; # ヘルプを出力
    \? ) usage >&2                     ;; # 上記以外のオプションの場合、標準エラーでヘルプを出力
  esac
done