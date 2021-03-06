class WishesController < ApplicationController

  load_and_authorize_resource #cancan


  # GET /wishes
  # GET /wishes.json
  def index
    @wishes = Wish.all.sort_by { |wish| wish.upvotes.count }
    @wishes = @wishes.reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wishes }
    end
  end

  # GET /wishes/1
  # GET /wishes/1.json
  def show
    @wish = Wish.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wish }
    end
  end

  # GET /wishes/new
  # GET /wishes/new.json
  def new

    @wish = Wish.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wish }
    end
  end

  # GET /wishes/1/edit
  def edit
    @wish = Wish.find(params[:id])
  end

  # POST /wishes
  # POST /wishes.json
  def create
    @wish = Wish.new(params[:wish])

    respond_to do |format|
      if @wish.save
        format.html { redirect_to @wish, notice: 'Your wish has been cast.' }
        format.json { render json: @wish, status: :created, location: @wish }
      else
        format.html { render action: "new" }
        format.json { render json: @wish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wishes/1
  # PUT /wishes/1.json
  def update
    @wish = Wish.find(params[:id])

    respond_to do |format|
      if current_user == @wish.user
        if @wish.update_attributes(params[:wish])
          format.html { redirect_to @wish, notice: 'Your wish has been amended.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @wish.errors, status: :unprocessable_entity }
        end
      else
        redirect_to :wishes_path
      end
    end
  end

  # GET /wishes/1/editClaim
  def editClaim
    @wish = Wish.find(params[:id])
  end

  def claim
      @wish = Wish.find(params[:id])

      claimmsg = params[:business] + " claimed this wish on " + Time.now().strftime("%A, %B %d, %Y at %I:%M%p") + "\n" + params[:message]
      new_params = {}
      new_params[:claimed] = true
      new_params[:claimmsg] = claimmsg
      #assemble msg to $Company claimed this wish at $time. $msg

      #put a hidden field with claimed boolean = true
      respond_to do |format|
        if @wish.update_attributes(new_params)
          @wish.textUsers
          format.html { redirect_to @wish, notice: 'Your wish has been claimed.' }
          format.json { head :ok }
        else
          format.html { render action: "editClaim" }
          format.json { render json: @wish.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /wishes/1
  # DELETE /wishes/1.json
  def destroy
    @wish = Wish.find(params[:id])
      @wish.destroy

      respond_to do |format|
        format.html { redirect_to wishes_url }
        format.json { head :ok }
      end
  end

end
