# procon

PROCedure ON how to easy procon!
簡単にプロコンする方法の手順！

![procon](https://user-images.githubusercontent.com/38717219/159499951-c4b4b082-3f3a-431f-a681-ebd581fbf493.png)

procon は プログラミングコンテストの解答環境です。TOPSIC や AtCoder でプログラミング問題を解答する時に使用します。

* **ロケットスタート:** コマンド一つで解答テンプレートを作成します。:rocket:
* **楽楽テスト:** コマンド１つで解答スクリプトのテストを実行できます。:laughing:
<!-- * **[追加予定]クリーンな実行:** ローカル端末を汚しません。TODO: 一旦pythonスクリプトをローカルで直接実行して、上記2項目を満たす。 --> 

## 提供コマンド

以下コマンドを利用してプロコン解答で**楽**をしましょう！

| コマンド | 説明 |
| --- | --- |
| `npm run template ${WORKNAME}` |  解答テンプレートを作成します。`WORKNAME`には作業名を与えます。言語のデフォルトは`python`です。 |
| `npm run test ${WORKNAME}` | `WORKNAME`配下のスクリプトをテストします。 |
| `npm run sample-setup` | サンプルを諸々セットアップします。忙しい人や開発者用です。 |

## ハンズオン(5分)

[AtCoder](https://atcoder.jp/home) から問題をお借りして、使い方を見てみましょう。
python3 で [AtCoder Beginners Selection PracticeA - Welcome to AtCoder](https://atcoder.jp/contests/abs/tasks/practice_1?lang=ja) を解答してみます。

![procon-demo](https://user-images.githubusercontent.com/38717219/159227464-759e9fcd-68bc-48e2-bd57-080037548d81.gif)
※デモ動画ではターミナルを利用していますが、普段使っているエディタを使うことで快適に試せます。VSCodeやAtomなど。

1. `template`コマンドで解答テンプレートを作成します。`WORKNAME`引数には問題名を使うのが良いでしょう。今回は`welcome-to-atcoder`とします。

    ```
    $ npm run template welcome-to-atcoder

    > procon@0.1.0 template
    > npm run template:python 3 "welcome-to-atcoder"


    > procon@0.1.0 template:python
    > ./src/create.sh python "3" "welcome-to-atcoder"

    welcome-to-atcoderをpythonでセットアップしました。
    ```

    解答テンプレートが作成されました。`welcome-to-atcoder`ディレクトリに移動して構成を確認します。

    ```
    $ cd welcome-to-atcoder
    $ tree .
    .
    ├── expect
    │   ├── 1.out
    │   ├── 2.out
    │   └── 3.out
    ├── stdin
    │   ├── 1.in
    │   ├── 2.in
    │   └── 3.in
    └── welcome-to-atcoder.py
    ```

    `welcome-to-atcoder.py`には解答スクリプトを書き込みます。`stdin`, `expect`配下には入出力ファイルが作成されましたが、今は全て空ファイルです。これらは後述する`test`コマンドで利用します。

1. `welcome-to-atcoder.py`に解答スクリプトを書き込みます。下記コードを書き込んで下さい。

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

    試しにスクリプトを実行してみましょう。`python3 welcome-to-atcoder.py` を実行します。入力待ちになっているはずなので、以下入力します。

    ```
    $ python3 welcome-to-atcoder.py
    1
    2 3
    test
    ```

    すると、スクリプトが結果を出力します。下記出力と同じならここまで問題ないです！

    ```
    6 test
    ```

1. 先程は直接スクリプトを実行して動作を確かめました。しかし、複数の期待する入出力セットがある場合、何度も打ち込み確認するのは**非常に面倒**です。proconではこの面倒なテストを自動化してくれるコマンドがあります!  
確認したい標準入力を打ち込む代わりに、`stdin`配下にファイルを作成して記述します。`xxx.in`という名前にして下さい。次に、`xxx.in`を入力としたときに期待する出力を`expect`配下にファイルを作成して記述します。`xxx.out`という名前にして下さい。  
`template`コマンドによって、すでに3ファイルずつ作成されています。それぞれ以下のように変更して下さい。

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

    3.in, 3.out は使わないので削除します。

    ```
    $ rm stdin/3.in expect/3.out 
    ```

    準備完了！`test`コマンドでテストを実行します。`WORKNAME`引数にはテストするスクリプトがあるディレクトリ名を指定して下さい。今回なら`welcome-to-atcoder`です。

    ```
    $ npm run test welcome-to-atcoder

    > procon@0.1.0 test
    > ./src/test.sh "welcome-to-atcoder"

    1: expect/1.out stdout/1.out ... OK!
    2: expect/2.out stdout/2.out ... OK!
    TOTAL: 2, PASS: 2, MISS: 0
    ```

    全てのテストに合格していることがわかりました！もし期待する出力でない場合はMISSにカウントされます。全てのテストに合格したら、参加しているプロコンのwebページからスクリプトを提出しましょう！

1. 解答し終わったディレクトリはそのまま残しても良いですし、`rm -rf ${WORKNAME}`として削除しても構わないでしょう。これまでのハンズオンを手軽に試したい場合、`sample-setup`コマンドが利用できます。  

基本的な使い方は以上です。プロコンをエンジョイしましょう！

## 動作条件

| name | version | description |
| --- | --- | --- |
| OS | どのOSでもよい | 動作確認したOSは以下。Ubuntu 20.04.2 LTS |
| node | 未確認 | インストールしてね♪ |
| 利用言語の実行環境| - | 例えばpython3.5, php7.4など |
<!-- | docker | version | TODO: versionかくにんする, macOSだとdocker起動してないとエラー | -->

## 注意
 - 解答コードの公開に制限があるコンテストは多いです。そもそも公開不可であったり、一定期間後でないと公開不可だったりします。解答ファイルの取り扱いはそれぞれのコンテスト規約に準拠してください。例えばAtCoderの規約では公開可能時間前の解答コード公開は規約違反になります。意図せずともpublicなリポートリポジトリにpushすると、それがmainブランチでなくても誰でも閲覧可能な状態になります。後悔することがないよう、十分注意してください。

<!-- ## 貢献 -->

<!-- - 絶賛募集中です。CONTORIBUTION.md を参照して下さい。 -->

## License

[MIT License](LICENSE)
