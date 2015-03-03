require 'rails_helper'

describe 'Comments Requests' do
  before(:all) do
    Post.destroy_all
    Comment.destroy_all
    @posts = FactoryGirl.create_list(:post, 25)
    @comments = FactoryGirl.create_list(:comment, 13)
  end

  describe '#index' do
    it 'gets all the comments for a post' do
      get "/posts/#{@posts.first.id}/comments"
      expect(response).to be_success
    end
  end

  describe '#create' do
    it 'should create a comment on that post and return the comment' do
      post "/posts/#{@posts.first.id}/comments",
      { comment: {
          body: "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui.",
          author: "JSONWharff"
        } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
    end
  end

  describe '#update' do
    it 'should update the comment and return the comment in json' do
      put "/comments/#{@comments.first.id}",
      { comment: {
          body: "Something else"
        }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
    end
  end

  describe '#destroy' do
    it 'kills the comment found by id' do
      comment = @comments.first
      delete "/comments/#{comment.id}"
      expect(response.status).to eq 204
    end
  end
end





