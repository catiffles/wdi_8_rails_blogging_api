require 'pry-byebug'
require 'rails_helper'

describe 'Post Requests' do
  before(:all) do
    Post.destroy_all
    @posts = FactoryGirl.create_list(:post, 25)
  end

  describe '#index' do
    it 'gets all of the posts' do
      get '/posts'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq 25
    end
  end

  describe '#create' do
    it 'should create a new post and return it' do
      post '/posts',
      { post: {
          title: "Vestibulum Lorem Sem Ligula Commodo",
          body: "Cras mattis consectetur purus sit amet fermentum. Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Donec ullamcorper nulla non metus auctor fringilla.",
          author: "JSONWharff"
        } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON

      post = JSON.parse(response.body)
      expect(post['title']).to eq "Vestibulum Lorem Sem Ligula Commodo"
    end
  end

  #  take notes in comments as you type
  describe '#show' do
    it 'should retreive a single post by id and return json' do
      @post = @posts.first
      get "/posts/#{@post.id}"
      expect(response).to be_success

      post = JSON.parse(response.body)
      expect(post['title']).to eq @post.title
    end
  end

  describe '#update' do
    it 'should update the parameters of the post and return that post' do
      @post = @posts.first
      put "/posts/#{@post.id}",
      { post: {
          title: "Something else",
          body: "A new body"
        }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON

      post = JSON.parse(response.body)
      expect(post['title']).to eq "Something else"
    end
  end

  describe '#destroy' do
    it 'should kill the post' do
      post = @posts.first
      delete "/posts/#{post.id}"
      expect(response.status).to eq 202
      # posts = JSON.parse(response.body)
      # expect(posts.length).to eq 24
    end
  end
end






























