class MessagesController < ApplicationController
  before_filter :require_user, :only => [:index,:new,:create]
  
  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end



  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.user_id = current_user.id #FIXME check if current_user is nil, could be nil!!
    #Split after commas and spaces
    params[:recipients][:mobile_numbers].split(/\,+\s*|\s+/).compact.each do |number|
      @message.recipients << Recipient.new(:mobile_number => number)
    end

    
    respond_to do |format|
      if @message.save
        format.html { redirect_to(new_url, :notice => 'Message was successfully sent.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

end
