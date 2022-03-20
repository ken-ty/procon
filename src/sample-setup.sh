#!/bin/bash
#
################################################################################
# README.md に書いてあるsampleをセットアップします。
#
################################################################################
# Version:
#   0.0.1 初期バージョン作成
################################################################################

work_name="welcome-to-atcoder"
npm run template:python 2 $work_name

# 同じ名前の作業ディレクトリがあったらwork_nameが変わる
# @see create.sh 
actual_work_name=`ls -1 | grep $work_name | tail -n 1`
work_name=$actual_work_name

cd $work_name
cat << EOF > "${work_name}.py"
# -*- coding: utf-8 -*-
# 整数の入力
a = int(input())
# スペース区切りの整数の入力
b, c = map(int, input().split())
# 文字列の入力
s = input()
# 出力
print("{} {}".format(a+b+c, s))
EOF

cd stdin
cat << EOF > 1.in
1
2 3
test
EOF
cat << EOF > 2.in
72
128 256
myonmyon
EOF

cd ../expect
cat << EOF > 1.out
6 test
EOF
cat << EOF > 2.out
456 myonmyon
EOF

echo "${work_name}をセットアップしました。"
