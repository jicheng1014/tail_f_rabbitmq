module FIR
  class CLI < Thor
    desc 'monitor', 'monitor directoy'
    def monitor(*args)
      TailFRabbitmq.monitor(args.first)
    end

    desc "reset", "reset config"
    def reset
      TailFRabbitmq.reset_config
    end

    desc 'help', 'Describe available commands or one specific command (aliases: `h`).'
    map Thor::HELP_MAPPINGS => :help
    def help(command = nil, subcommand = false)
      super
    end
  end
end
