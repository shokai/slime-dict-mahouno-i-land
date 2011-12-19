slime-dict-mahouno-i-land
=========================
魔法のiらんど からSlime用事書を生成する

## 必要なライブラリのインストール

    % gem install nokogiri


## 小説トップページのURLリストを取得する

    % ruby -Ku get_urls.rb 3 | grep "^http" | ruby extract_userid_bookid.rb | ruby make_book_index_urls.rb > book_url.txt


## 本文をダウンロードする

    % cat book_url.txt | ruby -Ku download_books.rb

