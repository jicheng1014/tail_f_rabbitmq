# encoding: utf-8

module FIR
  module Config
    CONFIG_PATH   = "#{ENV['HOME']}/.tail_f_rabbitmq_config"
    def default_config
      config = {
        url: "amqp://guest:guest@localhost:5672",
        queue: "log_line",
        eof: "END"
      }
    end

    def config
      unless File.exist?(CONFIG_PATH)
        @config = default_config
        write_config @config
      end
      @config ||= YAML.load_file(CONFIG_PATH).deep_symbolize_keys
    end

    def reload_config
      @config = YAML.load_file(CONFIG_PATH).deep_symbolize_keys
    end

    def write_config(hash)
      File.open(CONFIG_PATH, 'w+') { |f| f << YAML.dump(hash) }
    end

    def reset_config
      @config = default_config
      write_config @config
    end
  end
end

