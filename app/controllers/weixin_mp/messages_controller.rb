module WeixinMp
  class MessagesController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_filter :set_users, :only => [:reply]

    # 验证消息接口
    def verify
      # TODO: read token from config file
      token = "martin"

      if params[:signature] == Digest::SHA1.hexdigest([token, params[:nonce], params[:timestamp]].sort.join)
        render text: params[:echostr]
      else
        render nothing: true
      end
    end

    # 消息处理
    def reply
      # TODO: 根据实际需求覆盖此方法的定义
    end

    private
      # TODO: 配置正确的实际用户
      def set_users
        @to_user_name = "User1"
        @from_user_name = "User2"
      end

      def method_missing(method_name, *args)
        if method_name.to_s =~ /^send_(.+)$/
          @msg_type = $1
          if args[0].is_a? Hash
            @reply = args[0]
          else
            @replys = args[0]
          end
        else
          super
        end
      end
  end
end
