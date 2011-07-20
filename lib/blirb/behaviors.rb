# adds blirb functionality
module Blirb
  module Behaviors
    module ClassMethods
    end

    module InstanceMethods

      def help!
        puts %{
          task - print the current task's description
          done - test to see if you've completed the current task
          help! - view this menu (you just typed this..)
        }
      end

      def task
        Object.class_eval do
          puts @blirb.current_task.description if @blirb.current_task
        end
      end

      def done
        b = context.workspace.binding
        Object.class_eval do
          if @blirb.current_task.test!(b)
            puts "nice. that worked."
            puts "========================="
            @blirb.menu
          else
            puts "test failed. try again."
          end
        end
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end