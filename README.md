# [歯ブラシLife!]

## サービス概要

他の人がどんな歯ブラシを使用しているのか、使い終わった後はどうしているのかなど歯ブラシの情報収集をサポートする歯ブラシ専門のアプリです。
定期的な通知で歯ブラシの交換を手助けし、常に最適な状態の歯ブラシを使い続ける手助けも行います。

## アプリURL

[https://www.haburashi-life.com](https://www.haburashi-life.com/)

## 想定されるユーザー層

歯ブラシの種類、使い心地に興味がある方、どんな歯ブラシを使えばいいのか、他の人はどんな歯ブラシを使っているのか興味がある方が使用されることを想定しています。

## サービス作成の経緯

歯に関するアプリは既に存在していましたが、多くは歯磨きという「行動」に焦点が当たっているアプリで歯ブラシという「道具」に関するアプリの数が少ないと感じました。
また、以前から他の人が使用している歯ブラシはどういったものか、磨き方などはどうしているのかなど、他の人が歯ブラシをどう使っているか知る機会が少ないと感じ、
歯ブラシの使い方や使っている歯ブラシを情報共有できる場を作ろうと考えこのアプリを作成しました。
類似アプリの調査中にLION株式会社が歯ブラシのリサイクルプログラムを実施していることを知ったので、
歯ブラシを地球環境の改善のために再利用することも出来るのだということを皆さんにも是非知っていただきたいと考え、全国に存在する歯ブラシのリサイクル場所へのご案内も組み込んでいます。
リサイクルの促進と、一般的に歯ブラシは定期的に交換した方がいいとのこともあり、歯ブラシの交換時期を設定、お伝えする機能も実装しています。

## アプリの機能
|歯ブラシの登録|歯ブラシの材質、使用期間の設定|
|:---:|:---:|
|![README_search_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/3d9a396d-5fb3-43bb-91ae-784b508e799c)| ![README_edit_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/8de39a87-a8b2-41f2-9857-fef535124b55)|
|電動歯ブラシやこども用歯ブラシなど、一度に複数のジャンルから検索します|仕様上、ナイロン毛の歯ブラシを電動歯ブラシとして登録できてしまうので注意してください|

|デンタルグッズの登録|歯ブラシの詳細画面から使い終わった後を決める|
|:---:|:---:|
|![README_dentalitem_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/1dae69f2-1afd-4de7-9aea-f0d5dece2466)| ![README_show_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/f170b1d2-54d2-4ebd-a44c-b021b694fb3b)|
|歯ブラシの詳細画面から最大5つまで登録できます|掃除道具として使用した後にリサイクルを選ぶこともできます!|

|歯ブラシ一覧画面での検索機能|Xへのシェア機能|
|:---:|:---:|
|![README_indexsearch_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/7e1fa160-3d00-468c-988c-a2d25b7e5f0f)|![README_X_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/f5bffc77-f970-4660-af1e-bcd238fb9117)
|入力されたテキストを含む歯ブラシが入力候補に表示されます|Xへのシェアで歯ブラシをお勧めすることができます|

|LINEログイン機能|コメント機能|
|:---:|:---:|
|![README_login_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/daaa4cef-8ae4-473d-8b5e-17cb3a023e2d)|![README_comment_tutorial](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/77e43686-bffb-4f1e-9e29-ac58d38cab8f)|
|ゲストログインでLINE通知以外の機能をお試しすることができます|実際に使用した場合にコメントを記入できるように、使用開始から3日後に記入できます|

|LINE通知|
|:---:|
|![IMG_0664](https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/e167713a-46d2-4554-8290-9a55cc7fa27b)|
|設定した歯ブラシの交換日に通知する以外にも、使用開始がされていない歯ブラシの通知やコメント機能の解放を通知します|

## 主な使用技術
### バックエンド
- Ruby(3.2.2)
- Ruby On Rails(7.0.6)

### フロントエンド
- JavaScript
- Bootstrap(5.3.1)
- stimulus-autocomplete
- React(使用方法が荒削りなので洗練が必要)

### インフラ
- Heroku

### データベース
- PostgreSQL

### API
- LINE Messaging API
- 楽天API

### その他
- LINE ログイン
- Googleフォーム

## 実装済みの機能

### MVPリリース時(11/13)に実装した機能

- ユーザー情報編集機能
- LINEを使用したログイン機能
- 楽天APIを使用した歯ブラシの検索機能
- 検索結果に表示された歯ブラシの登録機能
- 使用されている歯ブラシの一覧表示
- 歯ブラシの編集機能
- Messaging APIを使用したユーザーへの通知機能

### 本リリース時(2/13)に実装した機能

- 歯磨き粉やフロスなど、歯ブラシ以外のデンタルグッズの登録機能
- 歯ブラシを使ってみた感想を投稿出来るコメント機能
- LINE公式アカウントにリッチメニューを実装
- LINEメッセージをFlex Message化
- 歯ブラシの一覧ページでの検索機能、および検索時のオートコンプリート機能
- ユーザー自身がこれまで使用した歯ブラシを確認できるマイページ機能

### 本リリース後に実装した機能
- 検索画面で入力補完を行うドロップダウンの実装
- 電動歯ブラシ使用時に専用のLINEメッセージを送信する機能
- X(twitter)へのシェアボタン
- 歯ブラシの削除機能
- 電動歯ブラシを使い終わる時などに使用できる使い終わるボタン
- Googleフォームを使用したお問い合わせフォーム
- 歯ブラシ編集画面のテキスト内容をブラシの種類や使用終了日によって変更する機能
- 掃除中の歯ブラシとリサイクルされた歯ブラシの数に応じた改善度を表示する環境改善ページの実装
- 使い終わっているものと同じ歯ブラシで使用開始を行える機能(現在は自身が使用していた歯ブラシで使用開始が行えます)
- 自分が使い終わった歯ブラシの詳細画面から同じ歯ブラシで再び使用開始できる機能
- Rspecを使用したテストコードの実装(実装進行中)

### 今後実装したいと考えている機能

- LINEメッセージの送信をActive Job、gem sidekiq、Redisを使用したバックエンド処理に更新
- 歯ブラシのリサイクルか掃除用具としての使用、どちらを選んだか他のユーザーに通知出来る機能
- 既に登録されている歯ブラシから使用を開始出来るようにし、その際にあなたの使用されている歯ブラシが使われました！とLINEの通知が来る機能
- LINE上でユーザーが特定のワードを送信した場合、内容に応じた歯の健康維持に関する情報をお伝えする機能
- 上記の他、ユーザーからの意見・要望で実現可能な機能

### テーブル構成
<img width="549" alt="Haburashi_ER" src="https://github.com/TAMETOMO8/Haburashi_Life/assets/117285256/32729065-c96c-42fc-b01a-4da29721c57f">

### 画面遷移図のURL(企画時)

[https://www.figma.com/file/wS1PyDnOw5EkgbP9OrOFEg/Haburashi_Life画面遷移図?type=design&node-id=0%3A1&mode=design&t=bu5gdxXYXJRyTrL9-1](https://www.figma.com/file/wS1PyDnOw5EkgbP9OrOFEg/Haburashi_Life%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=bu5gdxXYXJRyTrL9-1)


### Qiitaで作成した記事
- [【Rails】楽天APIで一度に複数のジャンルIDで検索してみた](https://qiita.com/TAMETOMO8/items/7a3cfec52c1c4f892cdc)
- [【個人開発】歯ブラシの情報収集と、リサイクルでの地球環境改善を目指すアプリを開発しました](https://qiita.com/TAMETOMO8/items/99204cdf86aba7244dc9)
