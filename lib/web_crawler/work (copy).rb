require 'thread'
module WebCrawler
  module Work
    @mutex = Mutex.new
    @pid = Process.pid

    # def process_page(url)
    #   puts url
    # end

    def self.release(thread)
      thread.cookielist = "flush"
      thread.cookielist = "all"
      thread.reset
      @mutex.synchronize { threads << thread }
    end

    # Return an easy from the pool.
    #
    # @example Return easy.
    #   Typhoeus::Pool.get
    #
    # @return [ Ethon::Easy ] The easy.
    def self.get
      @mutex.synchronize do
        if @pid == Process.pid
          threads.pop
        else
          # Process has forked. Clear all threads to avoid sockets being
          # shared between processes.
          @pid = Process.pid
          threads.clear
          nil
        end
      end || Thread.new
    end

    # Clear the pool
    def self.clear
      @mutex.synchronize {threads.clear}
    end

    private

    def self.threads
      @threads ||= []
    end
  end
end
