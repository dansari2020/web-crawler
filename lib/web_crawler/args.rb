require 'optparse'
module WebCrawler
  class Args
    def self.parse(args = ARGV)
      opts = OptionParser.new
      opts.separator ''
      opts.separator 'options:'
      opts.on('-e', '--export PRESENTATION', 'Export Products in (csv, json, html)') { |presentation| Config.export = presentation }
      opts.on('-s', '--sort NAME', 'sort by field') { |sort| Config.sort_by = sort }
      opts.on('-t', '--sort-type TYPE', 'Sort type (ASC/DESC)') { |type| Config.sort_type = type }
      opts.on('-p', '--pages NUMBER', 'Fetch number of page') do |number|
        Config.deep_page = number
      end
      opts.on('-l', '--log', 'Generate a log file in the current directory') { Config.log = true }
      opts.on('-h', '--help', 'Show this message') { puts(opts); exit }
      opts.parse!(args)
      validates_required_args
    rescue StandardError => e
      puts e.message
      exit
    end

    def self.validates_required_args
      if !Config.export.nil? && !WebCrawler::Output.respond_to?(Config.export)
        raise WebCrawler::Errors::ArgError, 'The format is not supported. Please use one of them (csv, html, json)'
      end
    end
  end
end
