#!/bin/bash
#
# run.sh は dockerコンテナでpythonファイルを実行します。
#
# Usage: ./run.sh -f python-file
# Usage: ./run.sh [option]
#
# Options:
#   -f ファイル名を指定
#   -h ヘルプを表示
#   -v バージョンを表示
#
# Version:
#   0.0.1


# TODO: 実装
# ヘッダの長さを取得する
function count_header_length() {
  echo "ヘッダの長さを取得する"
}

# usage() 使い方を表示する
function usage() {
  # usageはヘッダコメントから取得する.
  pattern='NR >= 2'
  action='{if (/^#/) { sub("^# ?", ""); print } else { exit }}'
  awk "$pattern $action" $0
}

# version() バージョンを表示する
function version() {
  pattern=''
  action='{if (/^# Version:/) { getline; sub("^#   ?", ""); print } }'
  awk "$pattern $action" $0
}

# file_run() pythonファイルをコンテナで実行する
function file_run() {
  # 公式に従ってdockerコマンドを叩きます
  # https://hub.docker.com/_/python/?tab=description
  # オプションメモ:
  # --volume=[ホスト側ディレクトリ:]コンテナ側ディレクトリ
  # --workdir=コンテナ内の作業用ディレクトリ
  filename=$1
  filename_stem=$(basename $filename ".py") # 拡張子抜きのfilename
  docker run \
    --interactive \
    --tty \
    --rm \
    --name "$filename_stem"_maked_runsh \
    --volume "$PWD":/usr/src/"$filename_stem" \
    --workdir /usr/src/"$filename_stem" python:3 python "$filename"
}

allow_options="cf:hv"
while getopts $allow_options option; do
  case $option in
    c  ) count_header_length ;; #TODO: デバッグ中
    f  ) file_run $OPTARG    ;; # ファイルの実行
    v  ) version   ;; # バージョンを出力
    h  ) usage     ;; # ヘルプを出力
    \? ) usage >&2 ;; # 上記以外のオプションの場合、標準エラーでヘルプを出力
  esac
done