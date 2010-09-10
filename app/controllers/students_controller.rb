class StudentsController < ApplicationController
  before_filter :require_user
      
  # GET /students
  # GET /students.xml
  def index
    @active_students = Student.find(:all, :order => 'name ASC', :conditions => {:active => true })
    @inactive_students = Student.find(:all, :order => 'name ASC', :conditions => {:active => false})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    if params[:course_id]
      @course = Course.find_by_id(params[:course_id])
    else
      @course = Course.last
    end
    @student = Student.find(params[:id])
    @notes = Note.find(:all, :conditions => {:student_id => @student.id})    
    @reviews_given = Review.completed.by_student(@student.id).for_quarter(@course)
    @reviews_received = Review.completed.for_student(@student.id).for_quarter(@course)
    @peer_grade = 0
    @reviews_received.each do |r|
      @peer_grade += r.grade.to_f 
    end
    @peer_grade = @peer_grade / @reviews_received.size unless @reviews_received.empty?
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  def toggle_active
    student = Student.find_by_id(params[:id])
    student.active = !student.active
    respond_to do |format|
      if student.save
        flash[:notice] = "#{student.name} has been marked as an <b>#{student.active ? 'active' : 'inactive'}</b> student."
        format.html { redirect_to(students_url) }
      else
        flash[:notice] = "We hit an error changing the active state for #{student.name}."
        format.html { redirect_to(students_url) }
      end
    end    
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new
    student = params[:student]
    @student.group_id = student[:group_id].to_i
    @student.email = student[:email].to_s
    @student.name = student[:name].to_s    

    respond_to do |format|
      if @student.save
        flash[:notice] = 'Student was successfully created.'
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])
    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] = 'Student was successfully updated.'
        format.html { redirect_to(@student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end
end
