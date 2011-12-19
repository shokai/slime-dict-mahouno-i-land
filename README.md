slime-dict-mahouno-i-land
=========================
魔法のiらんど からSlime用事書を生成する

## 必要なライブラリのインストール

    % gem install nokogiri


## 小説トップページのURLリストを取得する

    % ruby -Ku get_urls.rb 3 | grep "^http" | ruby extract_userid_bookid.rb | ruby make_book_index_urls.rb > book_url.txt


## 本文をダウンロードする

    % cat book_url.txt | ruby -Ku download_books.rb

dataディレクトリが作成され、中に保存されます

## 辞書を作成する

    % find data | grep "\/http:" | xargs cat | nkf -u | ruby -Ku make_dict.rb > raw-dict.txt
    % cat raw-dict.txt | sort | uniq -c | sort -r -n | awk '{print $2 " " $3 " " $4}' > mahouno-i-land-dict.txt

頻出順に並んだ辞書が生成される


## 名詞のみの辞書を作る例

    % cat mahouno-i-land-dict.txt | grep "\[名詞\]" > mahouno-i-land-dict-noun.txt
