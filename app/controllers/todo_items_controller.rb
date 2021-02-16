class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: %i[create update edit]


  def create
    @todo_item = @todo_list.todo_items.build(todo_item_params)
    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to @todo_list, notice: 'todo_item was successfully created.' }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @todo_item = @todo_list.todo_items.find(params[:id])
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to @todo_list, notice: 'Todo item was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = 'Todo list item was deleted.'
    else
      flash[:error] = 'Todo list item could not be deleted.'
    end
    redirect_to @todo_list
  end
  
  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: 'Todo item completed.'
  end

  private
  
  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

end
