require 'csv'

class PuzzlesController < ApplicationController
  # GET /puzzles
  # GET /puzzles.xml
  def index
    # @puzzles = Puzzle.all
    if(params[:lastUpdated] != nil)
      @puzzles = Puzzle.where("updated_at > ?", params[:lastUpdated]);
    else
      @puzzles = Puzzle.all;
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @puzzles }
    end
  end

  # GET /puzzles/1
  # GET /puzzles/1.xml
  def show
    @puzzle = Puzzle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @puzzle }
    end
  end

  # GET /puzzles/new
  # GET /puzzles/new.xml
  def new
    @puzzle = Puzzle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @puzzle }
    end
  end

  # GET /puzzles/1/edit
  def edit
    @puzzle = Puzzle.find(params[:id])
  end

  # POST /puzzles
  # POST /puzzles.xml
  def create
    @puzzle = Puzzle.new(params[:puzzle])

    respond_to do |format|
      if @puzzle.save
        flash[:notice] = 'Puzzle was successfully created.'
        format.html { redirect_to(@puzzle) }
        format.xml  { render :xml => @puzzle, :status => :created, :location => @puzzle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @puzzle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /puzzles/1
  # PUT /puzzles/1.xml
  def update
    @puzzle = Puzzle.find(params[:id])

    respond_to do |format|
      if @puzzle.update_attributes(params[:puzzle])
        flash[:notice] = 'Puzzle was successfully updated.'
        format.html { redirect_to(@puzzle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @puzzle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /puzzles/1
  # DELETE /puzzles/1.xml
  def destroy
    @puzzle = Puzzle.find(params[:id])
    @puzzle.destroy
    flash[:notice] = 'Puzzle was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(puzzles_url) }
      format.xml  { head :ok }
    end
  end
  
  def upload
    @puzzle = Puzzle.find(params[:id])
    @parsed_file=CSV::Reader.parse(params[:dump])
    n=0
    @parsed_file.each  do |row|
     questions = [row[1], row[2], row[3], row[4]].sort_by{rand}
     q = Question.new
     q.quiz_question = row[0]
     q.answer1 = questions[0]
     q.answer2 = questions[1]
     q.answer3 = questions[2]
     q.answer4 = questions[3]
     if(q.answer1 == row[1])
       q.correct_answer = 1;
     end
     if(q.answer2 == row[1])
        q.correct_answer = 2;
     end
     if(q.answer3 == row[1])
        q.correct_answer = 3;
     end
     if(q.answer4 == row[1])
        q.correct_answer = 4;
     end  
     q.puzzle_id = @puzzle.id
     q.difficulty = row[6]
     q.save
     n=n+1
    end
    respond_to do |format|
      if @puzzle.update_attributes(params[:puzzle])
        flash[:notice] = 'Puzzle was successfully updated'
        format.html { redirect_to(@puzzle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @puzzle.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
