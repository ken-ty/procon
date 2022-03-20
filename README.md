# procon

procon は プログラミングコンテストの解答環境です。


* **ロケットスタート:** コマンド一つで回答テンプレートを作成します。
* **楽楽テスト:** 回答スクリプトのテストがコマンド１つで実行できます。
<!-- * **[追加予定]クリーンな実行:** ローカル端末を汚しません。TODO: 一旦pythonスクリプトをローカルで直接実行して、上記2項目を満たす。 --> 

# 主なコマンド

- `npm run template WORKNAME` 回答テンプレートを作成します。デフォルトはpythonテンプレートです。
- `npm run test WORKNAME` WORKNAMEのスクリプトをテストします。

## Installation

[AtCoder](https://atcoder.jp/home) から問題をお借りして、使い方を見てみましょう。
python3 で [AtCoder Beginners Selection PracticeA - Welcome to AtCoder](https://atcoder.jp/contests/abs/tasks/practice_1?lang=ja) を解答してみます。

1. 解答環境を作成します。以下のコマンドを打ちます。引数には回答する問題の名前を付けると良いでしょう。今回は`welcome-to-atcoder`とします。

    ```
    $npm run template welcome-to-atcoder
    ```

    すると、解答環境が作成されます。作成されたディレクトリの構成を確認します。

    ```
    $tree welcome-to-atcoder/
    welcome-to-atcoder/
    ├── stdin
    │   ├── 1.in                 # このファイルに確認したい入力をコピペする
    │   ├── 2.in
    │   └── 3.in
    ├── expect
    │   ├── 1.out                # このファイルに期待する出力をコピペする
    │   ├── 2.out
    │   └── 3.out
    ├── stdout                    # この配下に標準出力の結果ファイルが格納される
    └── welcome-to-atcoder.py     # このファイルに解答する
    ```

1. welcome-to-atcoder/welcome-to-atcoder.py に 解答スクリプトを記述します。

    ```
    # -*- coding: utf-8 -*-
    # 整数の入力
    a = int(input())
    # スペース区切りの整数の入力
    b, c = map(int, input().split())
    # 文字列の入力
    s = input()
    # 出力
    print("{} {}".format(a+b+c, s))
    ```

1. 確認したい標準入力を試す代わりに、stdin配下にファイルを作成して記述します。また、期待する出力をexpect配下に**入力ファイルと同名の**ファイルを作成します。ただし、拡張子は異なって構いません。

    1.in
    ```
    1
    2 3
    test
    ```

    1.out
    ```
    6 test
    ```

    2.in
    ```
    72
    128 256
    myonmyon
    ```

    2.out
    ```
    456 myonmyon
    ```

    今回は3.in, 3.outは使わないので削除しました。

1. [追加予定]以下コマンドでテストが走ります。

    ```
    $npm run test welcome-to-atcoder
    1.in / 1.out ... OK
    2.in / 2.out ... OK
    2 / 2 case OK, complete!!
    ```

## 環境構築

| name | version | description |
| --- | --- | --- |
| OS | Ubuntu 20.04.2 LTS | 動作確認したOSです, macOS確認中 |
| docker | version | TODO: versionかくにんする, macOSだとdocker起動してないとエラー |
| node | 未確認 | インストールしてね。 TODO: .nvmrc作る |

## 注意
 - 解答コードの公開に制限があるコンテストは多いです。そもそも公開不可であったり、一定期間後でないと公開不可だったりします。解答ファイルの取り扱いはそれぞれのコンテスト規約に準拠してください。例えばAtCoderの規約では公開可能時間前の解答コード公開は規約違反になります。意図せずともpublicなリポートリポジトリにpushすると、それがmainブランチでなくても誰でも閲覧可能な状態になります。後悔することがないよう、十分注意してください。

## 参考

- [Python - Official Image | Docker Hub](https://hub.docker.com/_/python/?tab=description)
- [DockerコンテナでPythonスクリプトを動かす (主要なDockerオプション添え) - Qiita](https://qiita.com/zaki-lknr/items/f0ca0a28e5445884f30a)
- [シェルスクリプトの説明をコメントで書いてコマンドラインでヘルプとして表示する - Qiita](https://qiita.com/progrhyme/items/073dbf58844caa0e4b5c)

## License

[MIT License](LICENSE)
