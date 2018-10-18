require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "POST /tasks" do
    it 'should create new task' do
      expected_params = { "task": {
          name: 'Create first todo',
          status: false
      } }
      post '/tasks/', params: expected_params

      expect(response.content_type).to eq("application/json")
      expect(response_json['success']).to eq(true)
      expect(response_json['data']['attributes']['name']).to eq(expected_params[:task][:name])
      expect(response_json['data']['attributes']['status']).to eq(expected_params[:task][:status])
    end

    it 'should not create new task' do
      failure_params = { "task": {
          status: false
      } }

      post '/tasks/', params: failure_params

      expect(response.content_type).to eq("application/json")
      expect(response_json['success']).to eq(false)
      expect(response_json['errors']).to eq([['Name can\'t be blank']])
    end
  end

  describe 'GET /tasks' do

    it 'should get all tasks' do
      task = create(:task)
      get '/tasks'

      expect(response.content_type).to eq("application/json")
      expect(response_json['success']).to eq(true)
      expect(response_json['data'][0]['attributes']['name']).to eq(task.name)
      expect(response_json['data'][0]['attributes']['status']).to eq(task.status)
    end
  end

  describe 'UPDATE /tasks/:id' do
    let(:task) { create(:task) }
    it 'should update task' do
      new_name = "new #{task.name}"
      new_status = !task.status
      update_params = {"task": {"name": new_name, "status": new_status}}
      put '/tasks/' + task.id.to_s, params: update_params
      task.reload
      expect(response.content_type).to eq("application/json")
      expect(response_json['success']).to eq(true)
      expect(response_json['data']['attributes']['name']).to eq(new_name)
      expect(response_json['data']['attributes']['status']).to eq(new_status)
    end
  end

  describe 'DELETE /tasks' do
    let(:task) { create(:task) }

    it 'should get all tasks' do
      delete '/tasks/' + task.id.to_s

      expect(response.content_type).to eq("application/json")
      expect(response_json['success']).to eq(true)
    end
  end
end
