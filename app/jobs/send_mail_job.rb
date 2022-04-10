class SendMailJob < ApplicationJob
  queue_as :default

  def perform(args)
    puts "SendMailJob is performed ya #{args}"
  end
end
