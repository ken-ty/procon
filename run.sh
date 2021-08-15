#!/bin/bash
#
# run.sh は pythonファイルを実行します。
# dockerコンテナを立ち上げて実行しますが、実行後すぐに破棄されるので意識する必要はありません。
#
# Usage: ./run.sh -f filename
# Usage: ./run.sh [option]
#
# Options:
#   -f ファイル名を指定
#   -h ヘルプを表示
#   -v バージョンを表示
#
# Version:
#   0.0.1


# ヘッダの長さを取得する
function count_header_length() {
  count_header_length=0
  while read line; do
    if [[ $line =~ ^'#' ]]; then
      count_header_length=$(( count_header_length + 1 ))
    else
      break
    fi
  done < $0
  return $count_header_length
}

# usage() 使い方を表示する
function usage() {
  # usageはヘッダコメントから取得する.
  pattern='NR >= 2'
  action='{if (/^#/) { sub("^# ?", ""); print } else { exit }}'
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

# file_run() pythonファイルをコンテナで実行する
function run_file() {
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
  return 0
}

readonly ALLOW_OPTIONS="cf:hv"
while getopts $ALLOW_OPTIONS option; do
  case $option in
    f  ) run_file $OPTARG ;; # ファイルの実行
    v  ) version          ;; # バージョンを出力
    h  ) usage            ;; # ヘルプを出力
    \? ) usage >&2        ;; # 上記以外のオプションの場合、標準エラーでヘルプを出力
  esac
done