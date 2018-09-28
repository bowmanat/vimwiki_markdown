require 'active_support/inflector'

module VimwikiMarkdown
  class Options
    DEFAULTS = ["1", #force - 1/0
                 "markdown",
                 "md",
                 "~/vimwiki/site_html/",
                 "~/vimwiki/index.md",
                 "~/vimwiki/site_html/style.css",
                 "~/vimwiki/templates/",
                 "default",
                 ".tpl",
                 "-"].freeze

    FORCE            = 0
    SYNTAX           = 1
    EXTENSION        = 2
    OUTPUT_DIR       = 3
    INPUT_FILE       = 4
    CSS_FILE         = 5
    TEMPLATE_PATH    = 6
    TEMPLATE_DEFAULT = 7
    TEMPLATE_EXT     = 8
    ROOT_PATH        = 9

    attr_reader :force, :syntax, :extension, :output_dir,
                :input_file, :css_file, :template_path,
                :template_default, :template_ext, :root_path, :tags

=begin  force : [0/1] overwrite an existing file
          syntax : the syntax chosen for this wiki
          extension : the file extension for this wiki
          output_dir : the full path of the output directory, i.e. 'path_html'
          input_file : the full path of the wiki page
          css_file : the full path of the css file for this wiki
          template_path : the full path to the wiki's templates
          template_default : the default template name
          template_ext : the extension of template files
          root_path : a count of ../ for pages buried in subdirs
                      if you have wikilink [[dir1/dir2/dir3/my page in a subdir]]
                      then e %root_path% is replaced by '../../../'.
=end

    def initialize
      @force = arguments[FORCE] == "1" ? true : false
      @syntax = arguments[SYNTAX]
      @extension = ".#{arguments[EXTENSION]}"
      @output_dir = arguments[OUTPUT_DIR]
      @input_file = arguments[INPUT_FILE]
      @css_file = arguments[CSS_FILE]
      @template_path = arguments[TEMPLATE_PATH]
      @template_default = arguments[TEMPLATE_DEFAULT]
      @template_ext = arguments[TEMPLATE_EXT]
      @root_path = arguments[ROOT_PATH]
      @root_path = "./" if @root_path == "-"
      @tags = pull_tags
      raise "Must be markdown" unless syntax == 'markdown'
    end

    def get_file_contents
      file = File.open(input_file, "r")
      file.read
    end

    def pull_tags
      tags = Hash.new
      get_file_contents.split("\n").each do |li|
        tags['template'] = li.split.last if (li[/%template \S+./])
        tags['title'] = li.sub(/%title /, '') if (li[/%title .+/])
      end
      return tags
    end

    def template_filename
      return "#{template_path}#{tags['template']}#{template_ext}" if @tags['template']
      "#{template_path}#{template_default}#{template_ext}"
    end

    def self.arguments
      ARGV.empty? ? DEFAULTS : ARGV
    end

    def title
      return File.basename(tags['title'], "#{extension}").split(/ |\_/).map(&:capitalize).join(" ") if @tags['title']
      File.basename(input_file, "#{extension}").capitalize
    end

    def output_fullpath
      path = Pathname.new(input_file)
      uri = "#{path.basename("#{extension}").to_s.parameterize}"
      "#{output_dir}#{uri}.html"
    end

    private

    def arguments
      Options.arguments
    end
  end
end
