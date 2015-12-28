class CLI < Thor
  desc 'monitor', 'monitor directoy'
  def monitor(*args)
    TailFRabbitmq.monitor(args.first)
  end
end
