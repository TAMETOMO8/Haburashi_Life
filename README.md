# [歯ブラシLife ~Make up environment! ~]

## サービス概要

どんな歯ブラシを使用しているのか、どれくらいの期間使用、どのような使い方をしていたのか等の情報の発信、共有が出来る、
歯ブラシの情報共有サービスアプリです。


## 想定されるユーザー層
歯ブラシの種類、使い心地に興味がある方

## サービスコンセプト
歯に関するアプリは既に存在していますが、その多くは歯を磨く時間を楽しくするアプリや、
歯がうまく磨けるような手助けをするアプリなど、歯を綺麗にするという「行動」に焦点が当たっているアプリでした。
反面、歯ブラシという「道具」に関するアプリの数が少ないと感じたので、
他の人はどんな歯ブラシをどのように使用しているのか、逆に自分はどんな歯ブラシでどのような磨き方をしているのかの情報を
共有・発信する場を作ることで、自分に適した歯ブラシを探しやすくし、
より歯に対する関心を高められるのではとこのサービスを考案しました。
また、LION株式会社が歯ブラシのリサイクルプログラムを実施していることを知ったので、
全国各地に存在するリサイクル用の歯ブラシ回収場所をご案内することで、
歯ブラシを地球環境の改善のために再利用することも出来るのだということを、
皆さんにも知っていただけるのではないか思いこのサービスを考えました。
歯ブラシの材質、磨き方、歯ブラシを使い終わったあとについての情報を得られるようにし、
歯ブラシへの関心を高めていただけるようなサービスにしていきたいと考えています。


## 実装を予定している機能
### MVP
* ユーザー登録機能
* ユーザー編集機能
* LINEを使用したログイン機能
* 楽天APIを使用した歯ブラシの検索機能
* 検索結果に表示された歯ブラシの登録機能
* 使用されている歯ブラシの一覧表示
* 歯ブラシの編集機能
* Messaging APIを使用したユーザーへの通知機能

### 本リリース時に実装予定の機能
* ある程度以上のフロントエンドの充実
* Vue.jsを使用し、歯ブラシの検索、選択、情報登録までの一連の流れをSPA化
* 歯磨き粉やフロスなど、歯ブラシ以外のデンタルグッズの登録機能
* 自身が選択した歯ブラシを使ってみての感想を投稿出来る機能
* LINE公式アカウントにリッチメニューを実装
* 自身が使用している歯ブラシの削除機能
* 各ユーザーが使用した歯ブラシの履歴を確認出来る機能
* Rspecを使用したテストコードの実装
* 上記の他、ユーザーからの意見・要望で実現可能な機能

### 本リリース時、もしくは本リリース後に余裕があれば実装したい機能

* 歯ブラシのリサイクルか掃除用具としての使用、どちらを選んだか他のユーザーに通知出来る機能
* これまでどれだけの歯ブラシがリサイクルされたか、または掃除用具として使われているかを合計し、その合計をLINEメッセージで通知することで、環境改善状況をお知らせする機能
* どれだけの歯ブラシがリサイクルされたか、または掃除用具として使われているかをグラフで表示し、環境改善状況をお知らせする機能
* 既に登録されている歯ブラシから使用を開始出来るようにし、その際にあなたの使用されている歯ブラシが使われました！と通知が来るようにする
* 電動歯ブラシを使用する場合、歯ブラシの終了日時の通知以外にブラシの交換時期を通知出来るようにする機能
* LINE上でユーザーが特定のワードを送信した場合、内容に応じた歯の健康維持に関する情報をお伝えする機能

### 画面遷移図のURL
https://www.figma.com/file/wS1PyDnOw5EkgbP9OrOFEg/Haburashi_Life%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=bu5gdxXYXJRyTrL9-1

### サイトURL

https://haburashi-life-995f0c4dccdf.herokuapp.com/