require 'json'
require 'rb-inotify'
require_relative './util/config'
module FIR
  module Util
    extend ActiveSupport::Concern

    module ClassMethods
      include FIR::Config

      def monitor file_path
        @conn = Bunny.new(config[:url])
        @conn.start
        @ch = @conn.create_channel
        @q  = @ch.queue(config[:queue], :auto_delete => true)
        @x  = @ch.default_exchange
        notifier = INotify::Notifier.new
        notifier.watch file_path, :create, :recursive do |event|
          Thread.new do
            tail_f event.absolute_name do |lines, queue|
              send_msg event.name, lines
              queue.stop if lines.include? "end"
            end
          end
        end
        notifier.run
      end

      def tail_f file_path
        queue = INotify::Notifier.new
        open(file_path) do |file|
          yield file.read, queue # 先处理一次（create 时候的数据）
          queue.watch(file_path, :modify) do
            yield file.read, queue
          end
          queue.run
        end
      end

      def send_msg(name, line)
        msg = {
          name: name,
          line: line
        }
        @x.publish(msg.to_json, :routing_key => @q.name)
      end
    end
  end
end

