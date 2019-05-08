require 'fileutils'
module WebCrawler
  class Logger < ::Logger
    class << self
      def setting
        io = [STDOUT]
        io << log_file
        logger = Logger.new(MultiIO.new(*io))
        logger.level = Logger::INFO
        logger.formatter = proc do |_severity, _datetime, _progname, msg|
          "#{msg}\n"
        end
        @logger = logger
      end

      def info(str, show = WebCrawler::Config.log)
        @logger.info(str) if show
      end

      private

      def log_file
        time = Time.now.strftime('%Y-%m-%d')
        dir = Config.get('LOG_DIR')
        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
        log_file = File.open("#{dir}/#{time}.txt", 'a')
        log_file
      end
    end
  end
end
