#!/bin/bash
#
################################################################################
# run.sh は pythonファイルを実行します。
# dockerコンテナを立ち上げて実行しますが、実行後すぐに破棄されるので意識する必要はありません。
#
# Usage: ./run.sh -f filename
# Usage: ./run.sh -u use_program_language -f filename
#                    use_program_language={python3|python2|php7.4}
# Usage: ./run.sh [option]
#
# Options:
#   -f ファイル名を指定
#   -u 使用する言語を指定 (省略ならpython3と解釈)
#   -h ヘルプを表示
#   -v バージョンを表示
################################################################################
# Version:
#   0.0.1 初期バージョン作成
#   0.0.2 python2, php7.4に対応
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

# use_language() で選択できる言語を定義
CAN_USE_LANGUAGE_LIST=("python3" "python2" "php7.4")
# -uが省略されたときの言語を指定
DEFAULT_PROGRAM_LANGUAGE=${CAN_USE_LANGUAGE_LIST[0]}
USE_LANGUAGE=${DEFAULT_PROGRAM_LANGUAGE}

# use_language() 使用する言語を選択する
function use_language() {
  select_complete_flag=False
  for can_use_language in "${CAN_USE_LANGUAGE_LIST[@]}"; do
    if [ $1 = $can_use_language ]; then
      USE_LANGUAGE=$1
      select_complete_flag=True
    fi
  done
  if [ $select_complete_flag = False ]; then
      echo "エラー。その言語は対応していません。対応言語一覧を確認するにはxxxを実行してください。" >&2
      exit 1
  fi
  return 0
}

# python3_file_run() python3ファイルをコンテナで実行する
function python3_run_file() {
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
    --workdir /usr/src/"$filename_stem" python:3 python "$filename" # python2を利用したい場合、python:2とする
  return 0
}

# python2_file_run() python2ファイルをコンテナで実行する
function python2_run_file() {
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
    --workdir /usr/src/"$filename_stem" python:2 python "$filename"
  return 0
}

# php_file_run() phpファイルをコンテナで実行する
function php_run_file() {
  # 公式に従ってdockerコマンドを叩きます
  # https://hub.docker.com/_/php
  # オプションメモ:
  # --volume=[ホスト側ディレクトリ:]コンテナ側ディレクトリ
  # --workdir=コンテナ内の作業用ディレクトリ
  filename=$1
  filename_stem=$(basename $filename ".php") # 拡張子抜きのfilename

  docker run \
    --interactive \
    --tty \
    --rm \
    --name "$filename_stem"_maked_runsh \
    --volume "$PWD":/usr/src/"$filename_stem" \
    --workdir /usr/src/"$filename_stem" php:7.4-cli php "$filename"
  return 0
}

# run_file() ファイルをコンテナで実行する
function run_file() {
  if [   $USE_LANGUAGE = "python3" ]; then
    python3_run_file $1
  elif [ $USE_LANGUAGE = "python2" ]; then
    python2_run_file $1
  elif [ $USE_LANGUAGE = "php7.4"  ]; then
    php_run_file $1
  fi
  return 0
}

readonly ALLOW_OPTIONS="cf:hu:v"
while getopts $ALLOW_OPTIONS option; do
  case $option in
    f  ) run_file $OPTARG     ;; # ファイルの実行
    u  ) use_language $OPTARG ;; # 使用言語の指定
    v  ) version              ;; # バージョンを出力
    h  ) usage                ;; # ヘルプを出力
    \? ) usage >&2            ;; # 上記以外のオプションの場合、標準エラーでヘルプを出力
  esac
done