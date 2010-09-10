class ReviewsController < ApplicationController
  before_filter :require_user, :except => [:update_by_token,:update_by_token_save]
      
  # GET /reviews
  # GET /reviews.xml
  def index
    @course_id = Course.last.id
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  def send_email
    @review = Review.find_by_id(params[:review_id])
    Emailer.deliver_request_to_review(@review);
    flash[:notice] = "Sent"
    redirect_to root_url
  end
  def dispatch_review_request
    reviewer = params[:reviewer_id]
    reviewee = params[:reviewee_id]
    course_id = params[:course_id]
    @review = Review.create!(:reviewer_id => reviewer, :student_id => reviewee, :course_id => course_id)
    Emailer.deliver_request_to_review(@review)
    @review.update_attributes(:aasm_state => 'pending')
    flash[:notice] = "Sent"
    redirect_to root_url
  end
  
  def view
    if params[:course_id]
      @course = Course.find_by_id(params[:course_id])
    else
      @course = Course.last
    end
    
    @state = params[:state] || 'created'
    
    if @state == 'all'
      @reviews = @course.reviews
    else
      @reviews = Review.by_state_and_course(@state,@course.id)
    end                     
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  
  def list
    @reviews = Review.all
    @courses = Course.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  
  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @courses = Course.all
    @review = Review.new
    @students = Student.find(:all, :conditions => {:active => true})
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = Review.new(params[:review])
    @courses = Course.all
    @students = Student.find(:all, :conditions => {:active => true})
    @review.aasm_state = "completed"
    respond_to do |format|
      if @review.save
        flash[:notice] = 'Review was successfully created.'
        format.html { redirect_to(@review) }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
        format.html { redirect_to(reviews_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
  def update_by_token_save
    @token = params[:token]
    redirect_to(root_url) if @token.nil? || @token.empty?
    @review = Review.find_by_token(@token)
    redirect_to(root_url) if @token.nil? || @token.empty?
    @review.grade = params[:review][:grade].to_f
    @review.review = params[:review][:review]
    @review.saved_by_token = true
    respond_to do |format|
      if @review.save
        @review.update_attributes(:aasm_state => "completed")
        Emailer.deliver_review_submitted(@review)
        format.html { redirect_to(:controller=>'reviews',:action=>'update_by_token', :token => @token) }
      else
        format.html { render :action => "update_by_token", :locals => { :disabled => @review.aasm_state == 'completed' } }
      end
    end    
  end
  
  def update_by_token
    @token = params[:token]
    redirect_to(root_url) if @token.nil? || @token.empty?
    @review = Review.find_by_token(@token)
    redirect_to(root_url) if @review.nil?
    if @review.aasm_state == 'completed'
      @disabled = true
    end
      respond_to do |format|
        format.html # new.html.erb
      end
  end

end
