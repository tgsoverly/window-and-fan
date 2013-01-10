WindowAndFan::Application.routes.draw do
  root :to => "window_and_fan#index"

  get "window_and_fan/index"
  get "window_and_fan/recommend"

  get "weather/hourly"

end
