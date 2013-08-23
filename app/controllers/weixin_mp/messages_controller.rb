module WeixinMp
  class MessagesController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_filter :validate_legality
    before_filter :set_users, :only => [:reply]

    # 验证消息接口
    def verify
      render :text => params[:echostr]
    end

    # 消息处理
    def reply
      # 根据实际需求覆盖此方法的定义
    end

    private
      def validate_legality
        # TODO: read token from config file
        token = Rails.configuration.weixin_token

        unless params[:signature] == Digest::SHA1.hexdigest([token, params[:nonce], params[:timestamp]].sort.join)
          render text: "Forbidden", status: 403
        end
      end

      def set_users
        @to_user_name = params[:xml][:FromUserName]
        @from_user_name = params[:xml][:ToUserName]
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
