module Raws
  module Logger
    Logging.color_scheme('bright',
                         :levels => {
                             :info => :green,
                             :warn => :yellow,
                             :error => :red,
                             :fatal => [:white, :on_red]
                         },
                         :date => :blue,
                         :logger => :cyan,
                         :message => :magenta
    )

    Logging.appenders.stdout(
        'stdout',
        :layout => Logging.layouts.pattern(
            :pattern => '[%d] %-5l %c: %m\n',
            :color_scheme => 'bright'
        )
    )

    @logger = Logging.logger[self]
    log_file = "#{ROOT}/log/raws.log"

    unless File.exist?(log_file)
      new_log_path = File.dirname(log_file)
      FileUtils.mkdir_p(new_log_path) unless Dir.exist?(new_log_path)
      new_log_file = File.new(log_file, 'w+')
      new_log_file.puts("------> #{ DateTime.now } <------")
      new_log_file.close
    end

    @logger.add_appenders(
        Logging.appenders.stdout,
        Logging.appenders.rolling_file(log_file, :age => 'daily', :keep => 7),
        Logging.appenders.file(log_file)
    )

    @logger.level = :debug

    def self.debug(msg)
      @logger.debug(msg)
    end

    def self.info(msg)
      @logger.info(msg)
    end

    def self.warn(msg)
      @logger.warn(msg)
    end

    def self.error(msg, error = nil)
      error ||= StandardError
      @logger.error(msg)
      fail(error, msg)
    end

    def self.fatal(msg, error = nil)
      error ||= StandardError
      @logger.fatal(msg)
      fail(error, msg)
    end
  end
end
