#!/usr/bin/env python3

import os
import time
import copy
import urllib.request
import urllib.parse
from shlex import quote
from math import trunc
from bs4 import BeautifulSoup

# 生成される docset の名前。カレントディレクトリに作られる
new_docset_name = 'Python 3-ja.docset'
# 日本語ドキュメントの URL
base_url = 'https://docs.python.jp/3/'
# 英語版 docset のファイルパス
original_docset_path = '~/Library/Application Support/Dash/DocSets/Python_3/Python 3.docset/Contents/Resources/tarix.tgz'


# 日本語 html ファイルをダウンロード
def get_jp_resource(doc_path):
    if doc_path == 'genindex-Symbols.html':
        doc_path = urllib.parse.quote('genindex-記号.html')
    url = urllib.parse.urljoin(base_url, doc_path)
    response = urllib.request.urlopen(url)
    data = response.read().decode('utf-8')
    return data


# html ファイル1個ごとに作られる class
class Scraper(object):
    def __init__(self, docroot_path, doc_path):
        super(Scraper, self).__init__()
        self.doc_path = doc_path
        self.full_path = os.path.join(docroot_path, doc_path)
        with open(self.full_path) as fp:
            self.en_soup = BeautifulSoup(fp, "html.parser")
        jp_resource = get_jp_resource(doc_path)
        if jp_resource:
            self.ja_soup = BeautifulSoup(jp_resource, "html.parser")
        else:
            print("download failed")
        if self.doc_path == 'genindex.html': self.workaround_genindex_symbols()

    # 保存は上書き
    def save(self):
        # output = self.ja_soup.prettify(formatter=None)
        output = str(self.ja_soup)
        with open(self.full_path, 'w') as f:
            f.write(output)

    # Dash 上では意味のない script を除去
    def strip_unnecessary_elements(self):
        scripts = self.ja_soup.find_all("script")
        for script in scripts:
            script.clear()
            if script.attrs and script.attrs.get('src'):
                if script.attrs.get('src').endswith('_static/version_switch.js'): script.decompose()
                elif script.attrs.get('src').endswith('_static/translations.js'): script.decompose()
                elif script.attrs.get('src').endswith('_static/sidebar.js'): script.decompose()
                elif script.attrs.get('src').endswith('_static/doctools.js'): script.decompose()


    # 英語版の dashAnchor 要素を探して同じ場所に埋め込む
    def copy_dash_anchors(self):
        dash_anchors = self.en_soup.find_all(attrs={"class": "dashAnchor"})
        for dash_anchor in dash_anchors:
            ja_anchor = self.anchor_in_ja(dash_anchor)
            if ja_anchor is None:
                print("ERROR: anchor not found: " + dash_anchor['name'])
            else:
                ja_anchor.insert_before(copy.copy(dash_anchor))

    # dashAnchor と対応する要素を探す
    def anchor_in_ja(self, dash_anchor):
        # dashAnchor の次の要素が対応する要素 今のところ適合率100%
        next_sibling = dash_anchor.find_next_sibling()
        if next_sibling and next_sibling.has_attr('id'):
            label = next_sibling['id']
        else:
            label = os.path.basename(dash_anchor['name'])
        ja_anchor = self.ja_soup.find(attrs={"id": label})
        if ja_anchor is None:
            name = dash_anchor['name']
            label2 = os.path.basename(name)
            # ここだけ内容が異なる
            if name == '//apple_ref/Function/tabnanny.tokeneater': label2 = 'tabnanny.process_tokens'
            ja_anchor = self.ja_soup.find(attrs={"id": label2})
        return ja_anchor

    # 英語と日本語でファイル名が異なるものがあるので対処
    def workaround_genindex_symbols(self):
        bad_links = self.ja_soup.find_all(href="genindex-記号.html")
        for bad_link in bad_links:
            bad_link.attrs['href'] = "genindex-Symbols.html"


class DocsetJP(object):
    def __init__(self):
        super(DocsetJP, self).__init__()
        self.global_start_time = 0
        self.docroot_path = ""

    def start(self):
        self.global_start_time = time.time()
        if os.path.exists(new_docset_name):
            print('ERROR: "' + new_docset_name + '" already exists in current directory')
            return False
        if self.copy_from_original():
            self.do_main()
            m, s = divmod(time.time() - self.global_start_time, 60)
            print('All done. ({:d} min {:d} sec)'.format(trunc(m), trunc(s)))

    # 圧縮 docset の tarix.tgz を解凍。名前と Info.plist を修正して準備する
    def copy_from_original(self):
        archive_path = os.path.expanduser(original_docset_path)
        if not os.path.exists(archive_path):
            print('ERROR: Python 3.docset (and/or tarix.tgz) not found', archive_path)
            return False
        os.system('tar zxf {}'.format(quote(archive_path)))
        if not os.path.exists('Python 3.docset'):
            print('ERROR: could not extract tarix.tgz')
            return False
        os.rename('Python 3.docset', new_docset_name)
        real_path = os.path.realpath(new_docset_name)
        self.docroot_path = os.path.join(real_path, "Contents/Resources/Documents/doc/")
        plist_path = os.path.join(real_path, "Contents/Info.plist")
        os.system('/usr/libexec/PlistBuddy -c "set :CFBundleIdentifier python_ja" ' + quote(plist_path))
        os.system('/usr/libexec/PlistBuddy -c "set :CFBundleName Python 3-ja" ' + quote(plist_path))
        return True

    # docset 内の html を探してして処理
    def do_main(self):
        if not os.path.exists(self.docroot_path):
            print('ERROR: working Python 3.docset not found', self.docroot_path)
        for root, dirs, files in os.walk(self.docroot_path):
            for file in files:
                t, ext = os.path.splitext(file)
                if ext == ".html":
                    doc_path = os.path.relpath(os.path.join(root, file), self.docroot_path)
                    print(doc_path, end=' ...', flush=True)
                    start_time = time.time()
                    scraper = Scraper(self.docroot_path, doc_path)
                    scraper.copy_dash_anchors()
                    scraper.strip_unnecessary_elements()
                    scraper.save()
                    print(' ({:.2f} sec)'.format(time.time() - start_time))


if __name__ == '__main__':
    d = DocsetJP()
    d.start()
