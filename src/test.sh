#!/bin/bash
#
################################################################################
# test.sh は WORKING_DIRECTORY 配下のスクリプトを実行し、全テストケースに合格するか判定します。
#
# Usage: test.sh WORKING_DIRECTORY
#
################################################################################
# Version:
#   0.0.1 初期バージョン作成
#   0.0.2 WORKING_DIRECTORY配下の探索を追加
################################################################################

# printfで出力される文字に色を付与するフォーマットを定義します。
# Usage: printf "$RED\n" 'RED';
# echo だと シェルによって挙動が異なるらしいです。 @see https://qiita.com/ko1nksm/items/095bdb8f0eca6d327233
ESC=$(printf '\033') # \e や \x1b または $'\e' は使用しない
RED="${ESC}[31m%s${ESC}[m"
GREEN="${ESC}[32m%s${ESC}[m"

# FROMFILE と TOFILE が同一か判定します。
# @param {string} FROMFILE - 比較ファイル1
# @param {string} TOFILE - 比較ファイル2
# @return {bool} - 同一なら1, 異なるなら0を返す。
function isSame() {
    # 2ファイルの比較をする。出力は捨てる。
    if diff $1 $2 > /dev/null; then
        return 0;
    else
        return 1;
    fi
}

# 全てのテストに合格するか判定します。経過を標準出力します。
# 引数は任意の偶数個与えられます。奇数個ならエラーで停止します。
# 前方から2ファイルずつ比較します。OUTPUTFILE ANSWERFILE をセットで与えて下さい。
# @param {string} OUTPUTFILE - 回答ファイル1
# @param {string} ANSWERFILE - 正解ファイル1
# @param {string} OUTPUTFILE - 回答ファイル2
# @param {string} ANSWERFILE - 正解ファイル2
# ...
# @return {bool} - テスト合格なら1, 不合格なら0を返す。
function isAllTestPassed() {
    if test `expr $# % 2` -eq 1; then
        echo "error: 引数が奇数です。FROMFILE TOFILE をセットで与えて下さい。" 1>&2
        exit 1;
    fi

    test_cnt=0
    passed_cnt=0
    no_passed_cnt=0
    while [ "$1" != "" ]
    do
        test_cnt=`expr $test_cnt + 1`
        printf "$test_cnt: $1 $2 ... ";
        if isSame $1 $2; then
            printf "$GREEN\n" 'OK!';
            passed_cnt=`expr $passed_cnt + 1`
        else
            printf "$RED\n" 'NG';
            no_passed_cnt=`expr $no_passed_cnt + 1`
        fi
        # 引数をずらす
        shift 2
    done

    printf "TOTAL: $test_cnt, $GREEN, $RED\n" "PASS: $passed_cnt" "MISS: $no_passed_cnt";

    if [ $test_cnt -eq $passed_cnt ]; then
        return 1;
    else
        return 0;
    fi
}

################################################################################

# WORKING_DIRECTORY 配下のスクリプトを実行し、全てのテストに合格するか判定します。経過を標準出力します。
# @param {string} WORKING_DIRECTORY - テスト対象ディレクトリ
# @return {int} 正常終了なら0、そうでなければ1を返す。テストが通らなくてもエラーないなら正常終了なので0を返す。
# TODO: ファイルパスが間違っていたりテストケースがないとき、MISSにカウントでなくエラーログだして止めたい
WORKING_DIRECTORY=$1
cd $WORKING_DIRECTORY

mkdir -p stdout
TestPairList=""
input_files=`ls stdin | grep .in$`

for input_file in $input_files
do
    input_file_stem=`basename $input_file .in`
    output_file=$input_file_stem.out
    python3 $WORKING_DIRECTORY.py < stdin/$input_file > stdout/$output_file
    TestPairList+="expect/$output_file stdout/$output_file "
done

isAllTestPassed $TestPairList;
exit 0;
