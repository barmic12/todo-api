class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :status
end
