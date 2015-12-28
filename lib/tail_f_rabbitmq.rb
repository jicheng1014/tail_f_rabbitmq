require_relative "./tail_f_rabbitmq/version"
require 'yaml'
require 'bunny'
require "byebug"
require_relative "./tail_f_rabbitmq/patches"
require_relative "./tail_f_rabbitmq/util"

module TailFRabbitmq
  include FIR::Util
end

TailFRabbitmq.monitor("/tmp/")
