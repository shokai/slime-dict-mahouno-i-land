slime-dict-mahouno-i-land
=========================
魔法のiらんど からSlime用事書を生成する

## 小説トップページのURLリストを取得する

    % ruby -Ku get_urls.rb 3 | grep "^http" > url.txt
    % cat url.txt | ruby extract_userid_bookid.rb | ruby make_book_index_urls.rb > book_url.txt
