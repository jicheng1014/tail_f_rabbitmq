require_relative "./tail_f_rabbitmq/version"
require 'yaml'
require 'thor'
require 'bunny'
require_relative "./tail_f_rabbitmq/patches"
require_relative "./tail_f_rabbitmq/util"
require_relative "./tail_f_rabbitmq/cli"

module TailFRabbitmq
  include FIR::Util
end

FIR::CLI.start ARGV
