## 0.3.1 [March 10 2019]
Adds the ability to strip the extension correctly from vimwiki files.
For example, the file index.wiki was converted to index.wiki.html.

Thanks to @bowmanat for the PR.

This may also very likely break existing links, so, watch out there ;)

## 0.3.0 [March 10 2019]
Rebuilds vimwiki_markdown against the latest versions of Github/Markup etc.

The tools are somewhat different and so it's quite possible there will be breaking changes here, especially if
you have embedded HTML tags inside your markdown files. With a later version of https://github.com/github/markup
we should be able to pass options to commonmark and give ourselves more options.

This also uses rouge for syntax highlighting (fenced code blocks). Finding the documentation for that was fun ;)

### Breaking changes with 0.3
* This removes the title tag functionality which was introduced in 0.2.6 Unfortunately, having spaces in links meant that the new markdown parsing did not see the link as being valid (at least for [foo bar](foo bar) links). This may be reintroduced later.
* Requires ruby >= 2.3.8


## 0.2.6 [Jan 18 2018]
Add %template and %title options

## 0.2.4 [Jan 01 2017]
Make directory links work correctly. If you now link to
a directory [somedir](somedir/) then that link will be preserved
correctly.

## 0.2.3 [December 15th 2016]
Bugfix - multiple links on the same line were not processed correctly.

## 0.2.1 [December 15th 2016]
Allow %root_path% substitution in template file.

## 0.2.0 [March 6th 2016]
* Adds the ability for `[[source|title]]` style links to be parsed correctly
* Allows links with subdirectories `[[path/in/a/subdir/file]]` links to work
* Also allows vimwiki links formatted with markdown syntax to work, this
  feature is currently implemented on the dev branch. This means you can
  link to [my markdownfile](blah.md) and it'll be parsed correctly

## 0.1.3 [August 11th 2015]
* Adding the TableOfContents filter so that bookmarks are created.

## 0.1.1 [April 22nd 2015]
* Aaaaannnnd reverting that change.  While it totally works, it probably
  is overkill to have Druby running.  The major issue is that vimwiki
  deletes the old files as the filenames do not match.  Have added a
  note in the README to tell people how to make it faster.

## 0.1.0 [April 18th 2015]
* Quite a major change, we now spin up a Druby server in the background
  and then send the files across the wire to it.  This is somewhat
  invasive, but, on the plus side, takes the compilation time from
  several minutes down to seconds as we're not having to start
  up and require a whole bunch of files all the time.

## 0.0.4 [Dec 9th 2014]
* Use Github::Markup to prerender the markdown

## 0.0.3 [Oct 30th 2014]

* Raise warning if pygments placeholder is not present

## 0.0.2 [Sept 2014]

* Initial beta release of the vimwiki_markdown gem
