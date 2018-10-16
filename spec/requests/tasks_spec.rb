require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "POST /tasks" do
    it 'should create new task' do
      expected_params = {
          name: 'Create first todo',
          status: false
      }
      post '/tasks/', params: expected_params

      expect(response.content_type).to eq("application/json")
      expect(response_json['success']).to eq(true)
      expect(response_json['task']).to eq(params.to_json)
    end

    it 'should not create new task' do
      failure_params = {
          status: false
      }

      post '/tasks/', params: failure_params

      expect(response.content_type).to eq("application/json")
      expect(response_json['success']).to eq(false)
      expect(response_json['message']).to eq('name can\'t be blank')
    end
  end
end