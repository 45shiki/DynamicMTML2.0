# Alfieについて

## 概要

AlfieはSmartyを拡張したPHPのテンプレートエンジンです。
phpのプレゼンテーションからアプリケーションのロジックとコンテンツを分離して管理する事をとても簡単にします。
MTMLはMovable Typeのために開発されたシンプルで強力なテンプレート言語です(そして、日本ではもっとも普及しているテンプレート言語のひとつです)。
Alfieはデータベースがなくても動作します。つまり、MTMLを純粋なPHPのテンプレートエンジンとして活用できます。

## セットアップ

1. Movable Type をサーバーへアップロードします(MT\_DIR/php ディレクトリ以外のライブラリは必要ありません)。
2. DynamicMTML.pack を MT\_DIR/addons/DynamicMTML.pack にコピーします。
3. mt/mt-config.cgi に DefaultLanguage ja を記述します。
4. alfie.php のパス情報を環境にあわせて書き換えてアップロードします(このファイル名は変更しても構いません)。
5. \_htaccess.txt のパス情報(指定ファイル名)を環境にあわせて書き換えてアップロードしてから \_htaccess.txt を .htaccessにリネームします。
6. templates_c ディレクトリを作成し、書き込み可能なパーミッションを設定します。
7. example.htmlにアクセスします。Welcomeメッセージが正しく表示されればセットアップは完了です!