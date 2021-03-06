class DocsController < ApplicationController
before_action :find_doc, only: [:show, :edit, :update, :destroy]
def index
  @docs = Doc.where(user_id: current_user).order("created_at DESC")
end
def show
  @doc = Doc.find(params[:id])
end

def new
  @doc = current_user.docs.build
end
def create
  @doc = current_user.docs.build(doc_params)
  if @doc.save
    redirect_to @doc
  else
    render :action => 'new'
  end
end
def edit
  @doc = Doc.find(params[:id])
end
def update
   if @doc.update(doc_params) 
    redirect_to @doc
  else
    render 'edit'
   end
end
def destroy
  Doc.find(params[:id]).destroy
  #redirect_to @docs_path
  redirect_to :action => 'list'
end

private
def find_doc
  @doc = Doc.find(params[:id])
end
def doc_params
   params.require(:doc).permit(:title,:content)
  
end
end