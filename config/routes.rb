WeixinMp::Engine.routes.draw do
  get '/(.:format)', to: "messages#verify", defaults: { format: 'xml' }

  post '/(.:format)', to: "messages#reply", defaults: { format: 'xml' }
end
