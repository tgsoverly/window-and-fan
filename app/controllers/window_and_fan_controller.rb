class WindowAndFanController < ApplicationController
  def index
    
  end

  def recommend
    respond_to do |format|
      format.html do
        if request.xhr?
          render :partial => "recommendation", :locals => { :comment => @comment }, :layout => false, :status => :created
        else
          redirect_to :action => "index"
        end
      end
    end
  end

end
