#!/bin/bash
#
# Run PYTHON_SCRIPT on python3 container
#
# Usage:
#   ./run.sh -f filename [-h] [-v]
# Options:
#   -h Display help
#   -v Display version
#   -f [filename] run python script use python container
# Examples:
#   ./run.sh -f sample.py
# Version:
#   0.0.1
#

# TODO: 実装
# ヘッダの長さを取得する
function count_header_length() {
  echo "hoge"
}

# usage() 使い方を表示する
function usage() {
  # usageはヘッダコメントに書く.
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

# pythonファイルをコンテナで実行する
# TODO: ファイル名を受け付ける(現在はsample.py固定)
function file_run() {
    # -v, --volume=[ホスト側ディレクトリ:]コンテナ側ディレクトリ
    # -w, --workdir=コンテナ内の作業用ディレクトリ
    docker run \
        --interactive \
        --tty \
        --rm \
        --name python3_run \
        --volume "$PWD":/usr/src/myapp \
        --workdir /usr/src/myapp python:3 python sample.py
}

allow_options="cfhv"
while getopts $allow_options option; do
  case $option in
    c  ) count_header_length ;; #TODO: デバッグ中
    f  ) file_run  ;; # ファイルの実行
    v  ) version   ;; # バージョンを出力
    h  ) usage     ;; # ヘルプを出力
    \? ) usage >&2 ;; # 上記以外のオプションの場合、標準エラーでヘルプを出力
  esac
done