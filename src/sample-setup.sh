#!/bin/bash
#
################################################################################
# README.md に書いてあるsampleをセットアップします。
#
################################################################################
# Version:
#   0.0.1 初期バージョン作成
################################################################################

npm run template welcome-to-atcoder

cd welcome-to-atcoder
cat << EOF > welcome-to-atcoder.py
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

cd ..
rm stdin/3.in expect/3.out

echo "welcom-to-atcoderをセットアップしました。"
